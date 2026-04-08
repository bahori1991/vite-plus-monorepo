import { serverEnv } from "@tools/env/server";
import { cors } from "hono/cors";

export const corsMiddleware = () => {
  return cors({
    origin: [serverEnv.WEB_URL],
    allowHeaders: ["Content-Type", "Authorization"],
    allowMethods: ["GET", "POST", "PUT", "DELETE"],
    exposeHeaders: ["Content-Length"],
    maxAge: 600,
    credentials: true,
  });
};
