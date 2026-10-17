import { api } from "@/lib/v1";
import { rides } from "@/lib/ride-api";
export async function GET(request: Request) { return api(request, () => rides(request)); }
