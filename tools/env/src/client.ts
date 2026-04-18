/// <reference types="vite/client" />

import { createEnv } from "@t3-oss/env-core"
import z from "zod"

export const clientEnv = createEnv({
  clientPrefix: "VITE_",
  client: {
    VITE_WEB_URL: z.url(),
  },
  runtimeEnv: import.meta.env,
  emptyStringAsUndefined: true,
})
