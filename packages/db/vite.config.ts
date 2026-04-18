import { defineConfig } from "vite-plus"

export default defineConfig({
  pack: {
    dts: true,
    format: ["esm", "cjs"],
    sourcemap: true,
    exports: true,
  },
  lint: {
    options: {
      typeAware: true,
      typeCheck: true,
    },
  },
})
