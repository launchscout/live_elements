defmodule LiveElementsTestbedWeb.Router do
  use LiveElementsTestbedWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LiveElementsTestbedWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveElementsTestbedWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/todos", TodoLive
    live "/simple_guy", SimpleGuy
    live "/eat_pie", EatPie
    live "/with_component", WithComponent
    live "/data_table", Live.DataTable
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveElementsTestbedWeb do
  #   pipe_through :api
  # end

end
