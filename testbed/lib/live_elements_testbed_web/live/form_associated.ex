defmodule LiveElementsTestbedWeb.FormAssociated do
  use LiveElementsTestbedWeb, :live_view

  use LiveElements.CustomElementsHelpers

  custom_element :foo_input

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(form: to_form(%{"email" => "person@example.com", "username" => "foo"}))
      |> assign(email: "", bar: "")
    }
  end

  def render(assigns) do
    ~H"""
      <dl>
        <dd>Email</dd>
        <dt><%= @email %></dt>
        <dd>Bar</dd>
        <dt><%= @bar %></dt>
      </dl>
      <.simple_form for={@form} phx-change="validate" phx-submit="save">
        <.input field={@form[:email]} label="Email"/>
        <.input field={@form[:username]} label="Username" />
        <div>
          <.foo_input name="bar"></.foo_input>
        </div>
        <:actions>
          <.button>Save</.button>
        </:actions>
      </.simple_form>
    """
  end

  def handle_event("save", %{"email" => email, "bar" => bar} = params, socket) do
    IO.inspect(params)
    {:noreply, socket |> assign(email: email, bar: bar)}
  end
end
