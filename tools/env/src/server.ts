import { createEnv } from "@t3-oss/env-core"
import z from "zod"

export const serverEnv = createEnv({
  server: {
    NODE_ENV: z.enum(["development", "production", "test"]).default("development"),
    DATABASE_URL: z.string(),
    WEB_URL: z.url(),
    SERVER_URL: z.url(),
    BETTER_AUTH_SECRET: z.string().min(32),
    REACT_COMPILER: z.coerce.boolean(),
  },
  runtimeEnv: process.env,
  emptyStringAsUndefined: true,
})
