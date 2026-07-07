import * as esbuild from "esbuild";
import { fileURLToPath } from "node:url";
import path from "node:path";

const dir = path.dirname(fileURLToPath(import.meta.url));
const gallery = process.argv.includes("--gallery");

await esbuild.build({
  entryPoints: [path.join(dir, "src/index.ts")],
  bundle: true,
  outfile: path.join(dir, "dist/index.js"),
  format: "esm",
  platform: "browser",
  target: "es2020",
  external: ["react", "react-dom", "react/jsx-runtime"],
  loader: { ".css": "css" },
  sourcemap: true,
});

await esbuild.build({
  entryPoints: [path.join(dir, "src/styles/index.css")],
  bundle: true,
  outfile: path.join(dir, "dist/styles.css"),
  loader: { ".css": "css", ".woff2": "dataurl" },
});

console.log("Built dist/index.js + dist/styles.css");

if (gallery) {
  const ctx = await esbuild.context({
    entryPoints: [path.join(dir, "gallery/main.tsx")],
    bundle: true,
    outfile: path.join(dir, "gallery/dist/bundle.js"),
    format: "iife",
    platform: "browser",
    target: "es2020",
    jsx: "automatic",
    loader: { ".woff2": "dataurl" },
    sourcemap: true,
  });
  await ctx.watch();
  const { host, port } = await ctx.serve({
    servedir: path.join(dir, "gallery"),
    port: 4300,
  });
  console.log(`Gallery serving at http://${host}:${port}`);
}
