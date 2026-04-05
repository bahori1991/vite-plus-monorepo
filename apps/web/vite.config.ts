import { defineConfig } from "vite-plus";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact, { reactCompilerPreset } from "@vitejs/plugin-react";
import babel from "@rolldown/plugin-babel";
import path from "node:path";

const enableReactCompiler = process.env.REACT_COMPILER !== "false";

export default defineConfig({
  root: path.resolve(__dirname),
  server: {
    port: 3000,
    host: true,
  },
  resolve: {
    tsconfigPaths: true,
  },
  plugins: [
    tanstackStart(),
    viteReact(),
    enableReactCompiler ? babel({ presets: [reactCompilerPreset()] }) : undefined,
  ],
});
