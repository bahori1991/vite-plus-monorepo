import { defineConfig } from "vite-plus"
import { tanstackStart } from "@tanstack/react-start/plugin/vite"
import viteReact, { reactCompilerPreset } from "@vitejs/plugin-react"
import { devtools } from "@tanstack/devtools-vite"
import babel from "@rolldown/plugin-babel"
import tailwindcss from "@tailwindcss/vite"
import { serverEnv } from "@tools/env/server"

export default defineConfig({
  server: {
    port: 3000,
    host: true,
    strictPort: true,
  },
  plugins: [
    // TanStack Start の dev 用ミドルウェアを確実に載せる（vite-plus-core では ssr 環境の自動判定で
    // GET / が未処理のまま "Cannot GET /" になることがある）
    tanstackStart({ srcDirectory: "src" }),
    devtools(),
    viteReact(),
    tailwindcss(),
    serverEnv.REACT_COMPILER ? babel({ presets: [reactCompilerPreset()] }) : undefined,
  ],
  resolve: {
    tsconfigPaths: true,
  },
})
