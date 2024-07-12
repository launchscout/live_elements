defmodule LiveElementsTestbedWeb.TodoLive do
  use LiveElementsTestbedWeb, :live_view

  use LiveElements.CustomElementsHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(todos: ["hey"])}
  end

  @impl true
  def handle_event("add_todo", %{"todo" => todo}, %{assigns: %{todos: todos}} = socket) do
    {:noreply, socket |> assign(todos: todos ++ [todo])}
  end

end
