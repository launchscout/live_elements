# LiveElements

The goal of LiveElements is to improve the ergonomics of integrating custom HTML elements with [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view). We accomplish this by creating helper functions to make 
working with custom elements just as easy as any other LiveView functional component.

For example, let's say you have a `<todo-list>` custom element that has an attribute 
that takes a list of todos, and emits an `add_todo` Custom Event. LiveElements will 
generate a helper function (details below) which will wrap the custom element like
so:

```heex
<.todo_list todos={@todos}></.todo_list>
```

Serialization of todos to json happens automatically. In your live view you handle handle the `add_todo` event just like any other live view event:

```elixir
  def handle_event("add_todo", %{"todo" => todo}, %{assigns: %{todos: todos}} = socket) do
    {:noreply, socket |> assign(todos: todos ++ [todo])}
  end
```

## Installation

### Install hex package

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `live_elements` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_elements, "~> 0.1.0"}
  ]
end
```

### Install Custom Events hook

Presuming your custom element emits custom events you want to handle in live view, you'll need to install the `phoenix-custom-event-hook` npm package and add the hook 
to the live socket.

To install (from project dir):

```
npm install --prefix assets phoenix-custom-event-hook
```

Then, in `app.js` (or wherever you set up your live socket):

```js
import PhoenixCustomEventHook from 'phoenix-custom-event-hook';

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: {PhoenixCustomEventHook}})
```

# Usage

In the LiveViews where you want to call custom element helper functions do:

```
use LiveElements.CustomElementsHelpers
```

## Producing helper functions from a custom elements manifest file

LiveElements can consume a [custom elements manifest file](https://github.com/webcomponents/custom-elements-manifest) to produce helper functions
at compile time. To do so, in your config:

```elixir
config :live_elements, 
  custom_elements_manifest: Path.expand("../assets/custom-elements.json", __DIR__)
```

To produce a manifest file automatically from your custom element source code, you might want to check out the [custom element analyzer](https://custom-elements-manifest.open-wc.org/analyzer/getting-started/) from open-wc.org.

## Using the `custom_element` macro

If you are using a library that does not have a manifest, or don't wish to use one, you can 
also use the `custom_element` macro like so:

```elixir
  custom_element :bx_data_table, events: ["bx-table-header-cell-sort"]
```

This would then allow you to call `<.bx_data_table>` in your live view and `handle_event("bx-table-header-cell-sort", ...)` to respond to events.

# Example

The [live_elements_testbed](https://github.com/launchscout/live_elements_testbed) contains an 
example phoenix liveview app demonstrating all of the features of live_elements, as well as
integration tests for the live_elements project.




