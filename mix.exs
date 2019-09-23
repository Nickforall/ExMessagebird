defmodule ExMessagebird.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_messagebird,
      version: "0.1.0-pre-release.1",
      elixir: "~> 1.9",
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
      {:httpoison, "~> 1.5"},
      {:poison, "~> 4.0", only: [:dev, :test]}
    ]
  end
end
