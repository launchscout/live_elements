defmodule LiveElements.CustomElementsHelpers do
  import Phoenix.Component
  alias LiveElements.CustomElementsHelpers

  defmacro __using__(_opts) do
    imports =
      quote do
        require LiveElements.CustomElementsHelpers
        import LiveElements.CustomElementsHelpers
      end

    manifest_defs =
      for custom_element <- CustomElementsHelpers.custom_elements() do
        %{"tagName" => tag_name} = custom_element
        events = Map.get(custom_element, "events", [])
        event_names = events |> Enum.map(& &1["name"]) |> Enum.join(",")
        function_name = function_name(tag_name)

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

    [imports | manifest_defs]
  end

  def function_name(tag_name) do
    tag_name |> String.replace("-", "_") |> String.to_atom()
  end

  def custom_elements do
    ce_manifest_path = Application.get_env(:live_elements, :custom_elements_manifest)
    find_custom_elements(ce_manifest_path)
  end

  def serialize(assigns) do
    assigns |> Enum.map(fn {key, value} -> {key, serialize_value(value)} end)
  end

  def serialize_value(value) when is_binary(value), do: value

  def serialize_value(value) when is_number(value), do: value

  def serialize_value(%Phoenix.LiveComponent.CID{cid: cid}), do: cid

  def serialize_value(value), do: Jason.encode!(value)

  def find_custom_elements(nil), do: []

  def find_custom_elements(ce_manifest_path) do
    %{"modules" => modules} = File.read!(ce_manifest_path) |> Jason.decode!()

    modules
    |> Enum.map(& &1["declarations"])
    |> Enum.concat()
    |> Enum.filter(& &1["customElement"])
  end

  def custom_event_hook() do
    Application.get_env(:live_elements, :custom_event_hook, "PhoenixCustomEventHook")
  end

  def tagify(function_name), do: function_name |> Atom.to_string() |> String.replace("_", "-")

  defmacro custom_element(function_name, options \\ []) do
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
    attrs =
      assigns
      |> maybe_generate_id()
      |> Map.put("phx-hook", custom_event_hook())
      |> Map.put("phx-send-events", events)
      |> assigns_to_attributes()
      |> serialize()

    # Taken from `dynamic_tag` while awaiting fix for https://github.com/phoenixframework/phoenix_live_view/issues/3341

    assigns =
      assigns
      |> assign(
        tag_name: tag_name,
        escaped_attrs: Phoenix.LiveView.HTMLEngine.attributes_escape(attrs)
      )

    if assigns[:inner_block] && assigns.inner_block != [] do
      ~H"""
      <%= {:safe, [?<, @tag_name]} %><%= @escaped_attrs %><%= {:safe, [?>]} %><%= render_slot(@inner_block) %><%= {:safe, [?<, ?/, @tag_name, ?>]} %>
      """
    else
      ~H"""
      <%= {:safe, [?<, @tag_name]} %><%= @escaped_attrs %><%= {:safe, [?/, ?>]} %>
      """
    end
  end

  defp maybe_generate_id(%{id: _id} = assigns), do: assigns
  defp maybe_generate_id(assigns), do: Map.put(assigns, :id, UUID.uuid1())
end
