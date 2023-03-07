defmodule LiveElements.MixProject do
  use Mix.Project

  def project do
    [
      app: :live_elements,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.7.1"},
      {:phoenix_live_view, "~> 0.18.15"},
      {:jason, ">= 0.0.0"}
    ]
  end
end
