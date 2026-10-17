import { api } from "@/lib/v1";
import { rideQuality } from "@/lib/ride-export";
export async function GET(request: Request, context: { params: Promise<{ rideId: string }> }) {
  return api(request, async () => rideQuality((await context.params).rideId));
}
