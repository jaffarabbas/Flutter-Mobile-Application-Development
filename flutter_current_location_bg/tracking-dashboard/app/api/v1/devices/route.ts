import { api } from "@/lib/v1";
import { devices } from "@/lib/ride-api";
export async function GET(request: Request) { return api(request, devices); }
