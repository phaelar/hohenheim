defmodule App.Mixfile do
  use Mix.Project

  def project do
    [app: :app,
     version: "0.1.0",
     elixir: "~> 1.3",
     default_task: "server",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     aliases: aliases]
  end

  def application do
    [applications: [:logger, :extwitter, :ecto, :postgrex, :nadia],
     mod: {App, []}]
  end

  defp deps do
    [
      {:poison, "~>3.0.0", override: true},
      {:httpoison, "~>0.10.0"},
      {:extwitter, github: "parroty/extwitter"},
      {:ecto, "~>2.0.0"},
      {:postgrex, "~>0.12.0"},
      {:nadia, "~> 0.4.1"}
    ]
  end

  defp aliases do
    [server: "run --no-halt"]
  end
end
