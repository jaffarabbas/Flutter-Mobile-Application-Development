export class DashboardError extends Error {
  constructor(message: string, public status: number) { super(message); }
}
export async function getDashboardData<T>(path: string, key: string, signal?: AbortSignal): Promise<T> {
  const response = await fetch(`/api/v1/${path}`, {
    headers: { "X-Api-Key": key }, cache: "no-store", signal,
  });
  const json = await response.json();
  if (!response.ok || !json.success) throw new DashboardError(json.message ?? "Could not load data. Please try again.", response.status);
  return json.data;
}
export const errorMessage = (error: unknown) => error instanceof Error ? error.message : "Could not load data. Please try again.";
export const shortId = (id: string) => id.length > 16 ? `${id.slice(0, 8)}...${id.slice(-4)}` : id;
export const dateLabel = (ms: number) => new Date(ms).toLocaleDateString(undefined, { month: "short", day: "numeric", year: "numeric" });
export const clockLabel = (ms: number) => new Date(ms).toLocaleTimeString(undefined, { hour: "2-digit", minute: "2-digit" });
export function durationLabel(ms: number) {
  const seconds = Math.floor(Math.max(0, ms) / 1000);
  if (seconds < 60) return `${seconds}s`;
  if (seconds < 3600) return `${Math.floor(seconds / 60)}m ${seconds % 60}s`;
  return `${Math.floor(seconds / 3600)}h ${Math.floor(seconds % 3600 / 60)}m`;
}
export function relativeTime(ms: number | null, now: number) {
  if (ms === null) return "No fixes yet";
  const seconds = Math.max(0, Math.floor((now - ms) / 1000));
  if (seconds < 60) return `${seconds}s ago`;
  if (seconds < 3600) return `${Math.floor(seconds / 60)}m ago`;
  if (seconds < 86400) return `${Math.floor(seconds / 3600)}h ago`;
  return `${Math.floor(seconds / 86400)}d ago`;
}
export const measure = (value: number | null | undefined, unit: string) => value == null ? "—" : `${value.toLocaleString(undefined, { maximumFractionDigits: 1 })} ${unit}`;
