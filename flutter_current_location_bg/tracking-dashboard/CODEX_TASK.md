# Task for Codex: Ride sync API v1 + ride dashboard

Read `../docs/SYNC_API.md` first — it is the contract and must be implemented exactly.
Also read `AGENTS.md` (this Next.js version has breaking changes; check
`node_modules/next/dist/docs/` before writing route handlers or pages).

## Keep
- Next.js app router, `mssql`, Leaflet + OSM tiles (no API keys), `.env.local` config.
- Legacy `POST/GET /api/positions` and `dbo.device_positions` unchanged.
- No new npm dependencies unless strictly necessary (ask first).

## Database (`database/schema.sql`, idempotent `IF OBJECT_ID(...) IS NULL`)
```sql
dbo.rides (
  id NVARCHAR(36) PRIMARY KEY,
  device_id NVARCHAR(100) NOT NULL,
  started_at DATETIME2(3) NOT NULL,
  ended_at DATETIME2(3) NULL,
  status NVARCHAR(10) NOT NULL,            -- 'active' | 'ended'
  created_at DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
  updated_at DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME()
)
INDEX IX_rides_device_started (device_id, started_at DESC)

dbo.ride_points (
  id NVARCHAR(36) PRIMARY KEY,
  ride_id NVARCHAR(36) NOT NULL REFERENCES dbo.rides(id),
  device_id NVARCHAR(100) NOT NULL,
  lat FLOAT NOT NULL, lng FLOAT NOT NULL,
  accuracy FLOAT NULL, altitude FLOAT NULL, speed FLOAT NULL, bearing FLOAT NULL,
  provider NVARCHAR(20) NULL,
  is_mocked BIT NOT NULL DEFAULT 0,
  is_filtered BIT NOT NULL DEFAULT 0,
  filter_reason NVARCHAR(32) NULL,
  recorded_at DATETIME2(3) NOT NULL,       -- GPS fix time from the phone
  received_at DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME()
)
INDEX IX_ride_points_ride_recorded (ride_id, recorded_at)
INDEX IX_ride_points_device_recorded (device_id, recorded_at DESC)
```

## API (`app/api/v1/...`)
Implement every endpoint in `docs/SYNC_API.md`:
- `PUT /api/v1/rides/[rideId]` — upsert; never move `ended` back to `active`.
- `POST /api/v1/points/batch` — validate (UUID format, lat/lng range, 1–500 points,
  finite numbers), single transaction, insert-if-not-exists by id (e.g. table-valued
  insert into a temp table / `MERGE` / `INSERT ... WHERE NOT EXISTS`), auto-create
  unknown rides, return `received/inserted/duplicates`. Must handle 500 points fast
  (no 500 separate round-trips).
- `GET /api/v1/devices`, `GET /api/v1/rides`, `GET /api/v1/rides/[rideId]`,
  `GET /api/v1/rides/[rideId]/points` with `includeFiltered` and `since`.
- `X-Api-Key` check against env `API_KEY` (skip when unset). Add `API_KEY=` to `.env.example`.
- Times in JSON are epoch ms UTC both ways.
- Return 400 for validation errors, 401 for auth, 500/503 for DB errors (never 200 on failure).

## Dashboard (web UI)
1. **Devices panel**: each device, last seen ("12 s ago"), online dot if last fix < 30 s,
   active ride badge. Click → that device's rides.
2. **Rides list**: start time, duration, distance (good points), point counts
   (total / good / filtered), status, synced point count.
3. **Ride map**:
   - Blue polyline = good points; red circle markers = filtered points (toggle);
     grey thin line = raw track incl. filtered (toggle).
   - Popup on a point: time (local), accuracy, speed (m/s and km/h), filter_reason,
     provider, mocked.
   - Fit bounds once on load; **do not reset zoom on every refresh**.
   - Live mode for active rides: poll every 3 s with `since=<last recordedAt>`, append,
     "Follow" toggle (auto-disables when the user pans).
4. **Data-quality panel per ride** (this is an R&D tool): max gap between consecutive
   points (seconds), count of gaps > 5 s, median/p95 accuracy, counts per filter_reason,
   upload delay (median of `received_at - recorded_at`).
5. **GPX download** for a ride (good points, or all points).

## Checks
`npm.cmd run lint` and `npm.cmd run build` must pass. Update `README.md` with the v1
API and a curl example for each endpoint (PowerShell `Invoke-RestMethod` too).
Provide a small script `scripts/seed-demo-ride.mjs` that posts a fake ride through
the v1 API so the dashboard can be tested without a phone.
