# TRIP deployment and seed notes

## Baseline

Pinned upstream release `1.49.0` at `acb76591b02b80ec9d972a0617bc9206a01ea71a`.

## Deploy, reset, seed, and verify

```bash
./tester-env deploy
./tester-env seed
./tester-env verify
./tester-env reset
```

`deploy` builds the checked-out source with `docker-compose.tester-env.yml` and serves it at `http://localhost:18185`. `reset` runs project-scoped `docker compose down -v`, removing only this run's app resources and volume; it preserves the built image and shared Chromium infrastructure. `RUN_ID` scopes containers, volumes, and Compose project/network only; `IMAGE_TAG` controls the content-addressed image name.

Credentials: `tester` / `tester-env-trip-123`.

## Deterministic seed and verification

`seed` registers the tester user and creates **Alpine Research Weekend**, with **Arrival** on `2026-10-12` and booked **Lodge check-in** at `18:30`. `verify` authenticates through the app API and asserts that trip, day, and item.

## Browser smoke evidence

Independent browser smoke passed at `http://host.docker.internal:18185`: login with the deterministic credentials showed Alpine Research Weekend / Arrival / Lodge check-in, and creating then deleting a temporary plan was visibly successful.
