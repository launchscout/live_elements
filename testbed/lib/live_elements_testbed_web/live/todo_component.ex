defmodule LiveElementsTestbedWeb.TodoComponent do
  use LiveElementsTestbedWeb, :live_component

  use LiveElements.CustomElementsHelpers

  @impl true
  def update(assigns, socket) do
    {:ok, socket |> assign(todos: ["hey"])}
  end

  @impl true
  def handle_event("add_todo", %{"todo" => todo}, %{assigns: %{todos: todos}} = socket) do
    IO.inspect(todo)
    {:noreply, socket |> assign(todos: todos ++ [todo])}
  end

end
