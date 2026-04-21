import "@tanstack/react-start/server-only"
import { serverEnv } from "@tools/env/server"
import { drizzle } from "drizzle-orm/node-postgres"
import { Pool } from "pg"
import * as schema from "@packages/db/schemas"

export const pool = new Pool({
  connectionString: serverEnv.DATABASE_URL,
  max: 5,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
})

export const db = drizzle(pool, { schema })
