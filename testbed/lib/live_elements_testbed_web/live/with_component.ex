defmodule LiveElementsTestbedWeb.WithComponent do
  use LiveElementsTestbedWeb, :live_view


  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(todos: ["hey"])}
  end

end
