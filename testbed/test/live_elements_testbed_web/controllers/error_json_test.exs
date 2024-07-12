defmodule LiveElementsTestbedWeb.ErrorJSONTest do
  use LiveElementsTestbedWeb.ConnCase, async: true

  test "renders 404" do
    assert LiveElementsTestbedWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert LiveElementsTestbedWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
