defmodule LiveElementsTestbedWeb.Live.DataTable do
  use LiveElementsTestbedWeb, :live_view

  use LiveElements.CustomElementsHelpers

  custom_element :bx_data_table, events: ["bx-table-header-cell-sort"]

  @items [
    %{foo: "Foo1", bar: "Bar3", baz: "Baz1"},
    %{foo: "Foo2", bar: "Bar2", baz: "Baz2"},
    %{foo: "Foo3", bar: "Bar1", baz: "Baz3"}
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(items: @items)}
  end

  @impl true
  def handle_event("bx-table-header-cell-sort", %{"columnId" => sort_by}, socket) do
    {:noreply,
     socket
     |> assign(items: @items |> Enum.sort_by(&Map.get(&1, sort_by |> String.to_atom())))}
  end
end
