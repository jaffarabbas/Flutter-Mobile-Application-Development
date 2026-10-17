import { api } from "@/lib/v1";
import { rides, upsertRide } from "@/lib/ride-api";
type Context = { params: Promise<{ rideId: string }> };
export async function GET(request: Request, context: Context) {
  return api(request, async () => rides(request, (await context.params).rideId));
}
export async function PUT(request: Request, context: Context) {
  return api(request, async () => upsertRide(request, (await context.params).rideId));
}
