import { StrictMode } from "react"
import { TanStackDevtools } from "@tools/tanstack-devtools"
import { createRootRouteWithContext, HeadContent, Outlet, Scripts } from "@tanstack/react-router"
import { QueryClient } from "@tanstack/react-query"
import styles from "@apps/web/styles.css?url"

export const Route = createRootRouteWithContext<{ queryClient: QueryClient }>()({
  head: () => ({
    meta: [
      { charSet: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { title: "Tanstack Start" },
    ],
    links: [{ rel: "stylesheet", href: styles }],
  }),
  shellComponent: RootComponent,
})

function RootComponent() {
  return (
    <html lang="en">
      <head>
        <HeadContent />
      </head>
      <body>
        <StrictMode>
          <Outlet />
          <TanStackDevtools />
        </StrictMode>
        <Scripts />
      </body>
    </html>
  )
}
