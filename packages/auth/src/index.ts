import { betterAuth } from "better-auth"
import { drizzleAdapter } from "better-auth/adapters/drizzle"
import { db } from "@packages/db"
import * as authSchema from "@packages/db/schemas/auth"

export const auth = betterAuth({
  database: drizzleAdapter(db, {
    provider: "pg",
    schema: {
      users: authSchema.usersTable,
      accounts: authSchema.accountsTable,
      sessions: authSchema.sessionsTable,
      verifications: authSchema.verificationsTable,
    },
    usePlural: true,
  }),
})
