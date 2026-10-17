import { api } from "@/lib/v1";
import { ridePoints } from "@/lib/ride-api";
export async function GET(request: Request, context: { params: Promise<{ rideId: string }> }) {
  return api(request, async () => ridePoints(request, (await context.params).rideId));
}
