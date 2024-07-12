defmodule LiveElementsTestbedWeb.SimpleGuy do
  use LiveElementsTestbedWeb, :live_view

  use LiveElements.CustomElementsHelpers

  custom_element :simple_guy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(first_name: "Bob", age: 11)}
  end

end
