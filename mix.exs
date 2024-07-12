defmodule LiveElements.MixProject do
  use Mix.Project

  @description "A package to make custom elements and Phoenix LiveView so happy together"

  def project do
    [
      app: :live_elements,
      version: "0.2.2",
      elixir: "~> 1.14",
      description: @description,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        licenses: ["MIT"],
        links: %{"Github" => "https://github.com/launchscout/live_elements"}
      ],
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
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
      {:phoenix, ">= 1.7.1"},
      {:ex_doc, ">= 0.0.0"},
      {:phoenix_live_view, "~> 1.0.0-rc.6"},
      {:jason, ">= 0.0.0"},
      {:uuid, "~> 1.1"}
    ]
  end
end
