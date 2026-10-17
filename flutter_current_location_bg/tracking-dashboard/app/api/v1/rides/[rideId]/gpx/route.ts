import { api } from "@/lib/v1";
import { gpx } from "@/lib/ride-export";
export async function GET(request: Request, context: { params: Promise<{ rideId: string }> }) {
  return api(request, async () => gpx(request,(await context.params).rideId));
}
