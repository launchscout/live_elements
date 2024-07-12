defmodule LiveElementsTestbedWeb.Features.FormAssociatedTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "form associated", %{session: session} do
    session = session
    |> visit("/form_associated")
    |> assert_has(css("foo-input"))
    |> click(css("foo-input"))
    |> click(css("button"))
    |> assert_has(css("dt", text: "foo"))
  end
end
