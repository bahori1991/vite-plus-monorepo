import { defineConfig } from "vite-plus"
import viteReact, { reactCompilerPreset } from "@vitejs/plugin-react"
import tailwindcss from "@tailwindcss/vite"
import babel from "@rolldown/plugin-babel"

export default defineConfig({
  plugins: [
    viteReact(),
    tailwindcss(),
    babel({
      presets: [reactCompilerPreset()],
    }),
  ],
  resolve: {
    tsconfigPaths: true,
  },
})
