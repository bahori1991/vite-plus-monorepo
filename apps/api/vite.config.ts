import { defineConfig } from "vite-plus";
import devServer from "@hono/vite-dev-server";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export default defineConfig({
  root: path.resolve(__dirname),
  server: {
    port: 8080,
  },
  plugins: [
    devServer({
      entry: "src/app.ts",
    }),
  ],
  resolve: {
    tsconfigPaths: true,
  },
});
