import { defineConfig } from "vite-plus"
import viteReact from "@vitejs/plugin-react"
import tailwindcss from "@tailwindcss/vite"

export default defineConfig({
  plugins: [viteReact(), tailwindcss()],
  resolve: {
    tsconfigPaths: true,
  },
})
