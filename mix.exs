defmodule ExMessagebird.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_messagebird,
      version: "0.1.0-pre-release.6",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExMessagebird, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:jason, "~> 1.1"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "An API wrapper for the Messagebird API",
      licenses: ["MIT"],
      maintainers: ["Nick Vernij"],
      links: %{
        "GitHub" => "https://github.com/Nickforall/ExMessagebird"
      }
    ]
  end
end
