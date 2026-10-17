import { api } from "@/lib/v1";
import { batch } from "@/lib/ride-api";
export async function POST(request: Request) { return api(request, () => batch(request)); }
