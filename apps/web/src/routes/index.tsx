import { createFileRoute } from "@tanstack/react-router";
import { clientEnv } from "@repo/env/client";

export const Route = createFileRoute("/")({
  component: RouteComponent,
});

function RouteComponent() {
  const url = clientEnv.VITE_WEB_URL;
  return (
    <>
      <div>Hello "/"!</div>
      <p>URL: {url}</p>
    </>
  );
}
