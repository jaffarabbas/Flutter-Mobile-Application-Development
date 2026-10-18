import sql from "mssql";
import { readFile } from "node:fs/promises";
import path from "node:path";

let poolPromise: Promise<sql.ConnectionPool> | undefined;

export async function getSqlPool() {
  if (!poolPromise) {
    const config: sql.config = {
      server: process.env.DB_SERVER ?? "localhost",
      port: Number(process.env.DB_PORT ?? 1433),
      database: process.env.DB_DATABASE ?? "test2",
      user: process.env.DB_USERNAME ?? "sa",
      password: process.env.DB_PASSWORD ?? "",
      // Azure SQL serverless/free tier auto-pauses; the first connect can take ~1 min.
      connectionTimeout: Number(process.env.DB_CONNECT_TIMEOUT_MS ?? 15000),
      options: {
        encrypt: (process.env.DB_ENCRYPT ?? "true") === "true",
        trustServerCertificate:
          (process.env.DB_TRUST_SERVER_CERTIFICATE ?? "true") === "true",
        enableArithAbort: true,
      },
      pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000,
      },
    };

    poolPromise = (async () => {
      const pool = await new sql.ConnectionPool(config).connect();
      try {
        const schema = await readFile(path.join(process.cwd(), "database/schema.sql"), "utf8");
        await pool.request().batch(schema);
        return pool;
      } catch (error) {
        await pool.close();
        throw error;
      }
    })().catch((error) => {
      poolPromise = undefined;
      throw error;
    });
  }

  return poolPromise;
}
