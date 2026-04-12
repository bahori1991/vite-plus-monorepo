import { TanStackDevtools as Devtools } from "@tanstack/react-devtools"
import { ReactQueryDevtoolsPanel } from "@tanstack/react-query-devtools"
import { TanStackRouterDevtoolsPanel } from "@tanstack/react-router-devtools"
import { FormDevtoolsPanel } from "@tanstack/react-form-devtools"

export const TanStackDevtools = () => {
  return (
    <Devtools
      config={{ position: "bottom-left", hideUntilHover: true }}
      plugins={[
        {
          name: "Tanstack Query",
          render: <ReactQueryDevtoolsPanel />,
        },
        {
          name: "Tanstack Router",
          render: <TanStackRouterDevtoolsPanel />,
        },
        {
          name: "Tanstack Form",
          render: <FormDevtoolsPanel />,
        },
      ]}
    />
  )
}
