import { createFileRoute } from "@tanstack/react-router";
import { clientEnv } from "@tools/env/client";

export const Route = createFileRoute("/")({
  component: RouteComponent,
});

function RouteComponent() {
  const a = clientEnv.VITE_WEB_URL;
  return <div className="text-red-600">Hello {a}</div>;
}
