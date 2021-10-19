defmodule WeatherData.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather_data,
      version: "2110.5.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        ignore_warnings: ".dialyzer_ignore.exs"
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {WeatherData.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.0"},
      {:ecto_sql, "~> 3.0"},
      {:ecto_sqlite3, "~> 0.7.0"},
      {:logger_file_backend, "~> 0.0.10"},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
