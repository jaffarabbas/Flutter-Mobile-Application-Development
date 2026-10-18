import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  cacheComponents: true,
  partialPrefetching: true,
  // lib/db.ts reads this at runtime; serverless deploys (Vercel) must bundle it.
  outputFileTracingIncludes: {
    "/api/**/*": ["./database/schema.sql"],
  },
};

export default nextConfig;
