# Ride Sync API — v1 contract

Single source of truth for the mobile app (`lib/`, `android/`, `ios/`) and the
server (`tracking-dashboard/`). Change this file first, then both sides.

## Principles
- **Offline-first.** The phone's SQLite is the source of truth. The server is a copy.
- **Idempotent.** Rides and points are identified by client-generated UUIDs
  (lowercase, 36 chars). Re-sending anything is always safe and never duplicates.
- **GPS time, not receipt time.** All times in JSON are **epoch milliseconds UTC**.
  The server additionally records its own `received_at`.
- **Filtered points are uploaded too** (with `isFiltered` / `filterReason`) so the
  web can show or hide them, exactly like the app.

## Auth
Header `X-Api-Key: <key>` on every `/api/v1/*` request.
If the server env var `API_KEY` is empty/unset, the header is not checked (local testing).
Wrong/missing key when `API_KEY` is set → `401`.

## Common responses
- Success: `2xx` with `{ "success": true, ... }`
- Validation error: `400` `{ "success": false, "message": "..." }` — client must NOT retry the same payload forever (log it, skip/mark, see client rules).
- Auth error: `401`
- Server/DB error: `500` / `503` — client retries with backoff.

---

## 1. Upsert ride
`PUT /api/v1/rides/{rideId}`

```json
{
  "deviceId": "8f0c2b7e-....",
  "startedAt": 1760700000000,
  "endedAt": null,
  "status": "active"
}
```
- `status`: `"active" | "ended"`. `endedAt` required when `status = "ended"`.
- Insert if new, otherwise update `ended_at`, `status`, `updated_at`.
  An `ended` ride must never go back to `active`.
- Response `200` `{ "success": true, "rideId": "..." }`

## 2. Upload points (batch)
`POST /api/v1/points/batch`

```json
{
  "deviceId": "8f0c2b7e-....",
  "points": [
    {
      "id": "3b1d...",
      "rideId": "a7e2...",
      "lat": 24.860712,
      "lng": 67.001134,
      "accuracy": 4.8,
      "altitude": 12.3,
      "speed": 8.4,
      "bearing": 181.0,
      "provider": "fused",
      "isMocked": false,
      "isFiltered": false,
      "filterReason": null,
      "recordedAt": 1760700001000
    }
  ]
}
```
- 1–500 points per request. Nullable: `accuracy, altitude, speed, bearing, provider, filterReason`.
- `filterReason` ∈ `low_accuracy | speed_jump | mocked | stationary | jitter | null`
  (server stores any string ≤ 32 chars; do not hard-reject unknown values).
- **Insert-if-not-exists by `id`** — existing ids are ignored (counted as duplicates).
- If `rideId` is unknown, the server auto-creates the ride
  (`started_at` = earliest `recordedAt` in the batch for that ride, `status = 'active'`).
- Whole batch in one transaction: all stored or none.
- Response `200`:
```json
{ "success": true, "received": 120, "inserted": 118, "duplicates": 2 }
```
A `200` means every id in the request is now on the server → the client marks all of them synced.

---

## 3. Dashboard reads (used by the web, not the app)
- `GET /api/v1/devices` → each device with `lastSeenAt` (latest `recordedAt`),
  last lat/lng/accuracy/speed, `activeRideId` (or null).
- `GET /api/v1/rides?deviceId=&limit=50` → newest first, with `pointCount`,
  `goodCount`, `filteredCount`, `distanceM` (Haversine over good points), `durationMs`.
- `GET /api/v1/rides/{rideId}` → ride + same stats.
- `GET /api/v1/rides/{rideId}/points?includeFiltered=true&since=<epochMs>`
  → ordered by `recorded_at ASC`. `since` returns only points with `recordedAt > since`
  (for live polling). Max 20 000 rows.

The legacy `POST/GET /api/positions` endpoints stay unchanged.

---

## Client sync rules (mobile)
- Device id: UUID generated once on first launch, stored natively, never changes.
- Order per sync pass: upsert rides with `synced = 0` first, then points with
  `synced = 0` in batches of ≤ 500, oldest `recorded_at` first.
- On `200`: set `synced = 1` for exactly the uploaded ids.
- Ending a ride sets `rides.synced = 0` again so the `ended` status is uploaded.
- Triggers: every ~10 s while a ride is active (driven by incoming fixes), on Stop
  Ride, on app open, and manual "Sync now". Never on the main thread.
- On network error / 5xx: exponential backoff 10 s → 20 s → … → max 5 min.
  On 400: record the error, stop retrying that payload until config changes or
  manual sync (prevents an infinite loop).
- Sync must run in native code so it continues while the Flutter engine is dead.
- Tracking never waits on sync. No network → points simply stay `synced = 0`.
