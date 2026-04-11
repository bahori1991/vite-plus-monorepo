import { createEnv } from "@t3-oss/env-core";
import z from "zod";

export const serverEnv = createEnv({
  server: {
    NODE_ENV: z.enum(["development", "production", "test"]).default("development"),
    DATABASE_URL: z.string(),
    WEB_URL: z.url(),
    SERVER_URL: z.url(),
    BETTER_AUTH_SECRET: z.string().min(32),
    REACT_COMPILER: z.coerce.boolean(),
  },
  runtimeEnvStrict: {
    NODE_ENV: process.env["NODE_ENV"],
    DATABASE_URL: process.env["DATABASE_URL"],
    WEB_URL: process.env["WEB_URL"],
    SERVER_URL: process.env["SERVER_URL"],
    BETTER_AUTH_SECRET: process.env["BETTER_AUTH_SECRET"],
    REACT_COMPILER: process.env["REACT_COMPILER"],
  },
  emptyStringAsUndefined: true,
});
