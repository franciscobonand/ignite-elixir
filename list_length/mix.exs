defmodule ListLength.MixProject do
  use Mix.Project

  def project do
    [
      app: :list_length,
      version: "0.1.0",
      elixir: "~> 1.15",
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
      {:json_response, git: "https://github.com/joaopealves/json_response"}
    ]
  end
end
