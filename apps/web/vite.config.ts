import { defineConfig } from "vite-plus";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact, { reactCompilerPreset } from "@vitejs/plugin-react";
import { devtools } from "@tanstack/devtools-vite";
import babel from "@rolldown/plugin-babel";
import tailwindcss from "@tailwindcss/vite";

const enableReactCompiler = process.env["REACT_COMPILER"] !== "false";

export default defineConfig({
  server: {
    port: 3000,
    host: true,
    strictPort: true,
  },
  plugins: [
    devtools(),
    tanstackStart({ srcDirectory: "src" }),
    viteReact(),
    tailwindcss(),
    enableReactCompiler ? babel({ presets: [reactCompilerPreset()] }) : undefined,
  ],
  resolve: {
    tsconfigPaths: true,
  },
});
