import { defineConfig } from "vite-plus"
import { tanstackStart } from "@tanstack/react-start/plugin/vite"
import viteReact, { reactCompilerPreset } from "@vitejs/plugin-react"
import { devtools } from "@tanstack/devtools-vite"
import { nitro } from "nitro/vite"
import babel from "@rolldown/plugin-babel"
import tailwindcss from "@tailwindcss/vite"

const reactCompiler = !!process.env["REACT_COMPILER"]

export default defineConfig({
  server: {
    port: 3000,
    strictPort: true,
  },
  fmt: {
    semi: false,
  },
  plugins: [
    tanstackStart({ srcDirectory: "src" }),
    nitro(),
    devtools(),
    viteReact(),
    tailwindcss(),
    reactCompiler ? babel({ presets: [reactCompilerPreset()] }) : undefined,
  ],
  resolve: {
    tsconfigPaths: true,
  },
})
