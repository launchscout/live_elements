defmodule LiveElements.CustomElementsHelpers do
  import Phoenix.Component
  alias LiveElements.CustomElementsHelpers

  defmacro __using__(_opts) do
    for custom_element <- CustomElementsHelpers.custom_elements() do
      %{"tagName" => tag_name, "events" => events} = custom_element
      event_names = events |> Enum.map(& &1["name"]) |> Enum.join(",")
      function_name = function_name(tag_name)
      IO.inspect(function_name, label: "defining function")

      quote do
        def unquote(function_name)(assigns) do
          LiveElements.CustomElementsHelpers.custom_element_tag(
            assigns,
            unquote(tag_name),
            unquote(event_names)
          )
        end
      end
    end
  end

  def function_name(tag_name) do
    tag_name |> String.replace("-", "_") |> String.to_atom()
  end

  def custom_elements do
    ce_manifest_path = Application.get_env(:live_elements, :custom_elements_manifest)
    %{"modules" => modules} = File.read!(ce_manifest_path) |> Jason.decode!()
    modules |> find_custom_elements()
  end

  def serialize(assigns) do
    assigns |> Enum.map(fn {key, value} -> {key, Jason.encode!(value)} end)
  end

  def find_custom_elements(modules) do
    modules
    |> Enum.map(& &1["declarations"])
    |> Enum.concat()
    |> Enum.filter(& &1["customElement"])
  end

  def custom_event_hook() do
    Application.get_env(:live_elements, :custom_event_hook, "PhoenixCustomEventHook")
  end

  def tagify(function_name), do: function_name |> Atom.to_string() |> String.replace("_", "-")

  defmacro custom_element(function_name, options) do
    tag_name = tagify(function_name)
    events = Keyword.get(options, :events, [])
    quote do
      def unquote(function_name)(assigns) do
        LiveElements.CustomElementsHelpers.custom_element_tag(
          assigns,
          unquote(tag_name),
          unquote(events |> Macro.escape() |> Enum.join(","))
        )
      end
    end
  end

  def custom_element_tag(assigns, tag_name, events) do
    attrs = assigns_to_attributes(assigns) |> serialize()

    assigns =
      assigns
      |> assign(
        tag_name: tag_name,
        attrs: attrs,
        events: events,
        custom_event_hook: custom_event_hook()
      )

    ~H"""
    <.dynamic_tag name={@tag_name} {@attrs} phx-hook={@custom_event_hook} phx-send-events={@events}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end
end
