import { defineConfig } from "drizzle-kit"
import { serverEnv } from "@tools/env/server"

export default defineConfig({
  out: "./drizzle",
  schema: "./src/schemas",
  dialect: "postgresql",
  dbCredentials: {
    url: serverEnv.DATABASE_URL,
  },
})
