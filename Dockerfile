# syntax=docker/dockerfile:1
# Node builder
FROM node:22 AS build
WORKDIR /app
COPY src/package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci
COPY src .
RUN npm run build

# Server
FROM python:3.12-slim
LABEL maintainer="github.com/itskovacs"
LABEL description="Minimalist POI Map Tracker and Trip Planner"
WORKDIR /app
COPY backend/trip/requirements.txt /tmp/requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip pip install -r /tmp/requirements.txt
COPY backend .
COPY --from=build /app/dist/trip/browser ./frontend
EXPOSE 8000
CMD ["fastapi", "run", "/app/trip/main.py", "--host", "0.0.0.0", "--port", "8000"]
