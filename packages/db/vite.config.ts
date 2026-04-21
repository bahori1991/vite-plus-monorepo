import { defineConfig } from "vite-plus"

export default defineConfig({
  pack: {
    clean: true,
    dts: true,
    entry: ["src/**/*.ts"],
    format: ["esm"],
    sourcemap: true,
  },
  lint: {
    options: {
      typeAware: true,
      typeCheck: true,
    },
  },
})
