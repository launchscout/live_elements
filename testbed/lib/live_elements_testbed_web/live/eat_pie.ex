defmodule LiveElementsTestbedWeb.EatPie do
  use LiveElementsTestbedWeb, :live_view

  use LiveElements.CustomElementsHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(pies_eaten: %{"cherry" => 1, "apple" => 1, "blueberry" => 1})}
  end

  @impl true
  def handle_event("eat_pie", %{"pie" => pie}, %{assigns: %{pies_eaten: pies_eaten}} = socket) do
    pies_eaten = Map.update(pies_eaten, pie, 1, &(&1 + 1))
    {:noreply, socket |> assign(pies_eaten: pies_eaten)}
  end

end
