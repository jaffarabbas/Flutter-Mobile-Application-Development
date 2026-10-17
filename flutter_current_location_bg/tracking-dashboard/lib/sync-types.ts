export type RidePoint = {
  id: string; rideId: string; deviceId: string; lat: number; lng: number;
  accuracy: number | null; altitude: number | null; speed: number | null;
  bearing: number | null; provider: string | null; isMocked: boolean;
  isFiltered: boolean; filterReason: string | null; recordedAt: number; receivedAt: number;
};
export type Ride = {
  id: string; deviceId: string; startedAt: number; endedAt: number | null;
  status: "active" | "ended"; createdAt: number; updatedAt: number;
  pointCount: number; goodCount: number; filteredCount: number;
  distanceM: number; durationMs: number;
};
export type Device = {
  deviceId: string; lastSeenAt: number | null; lat: number | null; lng: number | null;
  accuracy: number | null; speed: number | null; activeRideId: string | null;
};
