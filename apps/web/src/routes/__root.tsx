import { createRootRoute, HeadContent, Outlet, Scripts } from "@tanstack/react-router";
import { StrictMode } from "react";

export const Route = createRootRoute({
  head: () => ({
    meta: [
      { charSet: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { title: "Tanstack Start" },
    ],
  }),
  component: RootComponent,
  notFoundComponent: () => {
    <p> 404 Not Found </p>;
  },
});

function RootComponent() {
  return (
    <html>
      <head>
        <HeadContent />
      </head>
      <body>
        <StrictMode>
          <Outlet />
        </StrictMode>
        <Scripts />
      </body>
    </html>
  );
}
