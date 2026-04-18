import { Hono } from "hono"
import { corsMiddleware } from "@apps/api/middleware/cors"
import { serverEnv } from "@tools/env/server"

const app = new Hono()
  .use("*", corsMiddleware())
  .basePath("/api")
  .get("/", (c) => {
    return c.text(`reactCompiler: ${serverEnv.REACT_COMPILER}`)
  })

export default app
