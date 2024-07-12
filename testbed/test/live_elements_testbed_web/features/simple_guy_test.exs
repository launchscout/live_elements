defmodule LiveElementsTestbedWeb.Features.SimpleGuyTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "simple guy", %{session: session} do
    session = session
    |> visit("/simple_guy")
    |> assert_has(css("simple-guy"))

    :timer.sleep(100)

    session
    |> find(css("simple-guy"))
    |> shadow_root()
    |> assert_has(css("div", text: "My name is Bob and I am 11 years old"))
  end
end
