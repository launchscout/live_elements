defmodule LiveElementsTestbedWeb.Features.FormAssociatedTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "form associated", %{session: session} do
    session = session
    |> visit("/form_associated")
    |> assert_has(css("foo-input"))

    :timer.sleep(100)

    session = session
    |> click(css("foo-input"))
    |> click(css("button"))

    :timer.sleep(100)
    session
    |> assert_has(css("dt", text: "foo"))
  end
end
