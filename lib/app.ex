require IEx;

defmodule App do
  use Application
  require Logger

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(App.Tweets, []),
      worker(App.DevQuotes, []),
      worker(App.Poller, []),
      worker(App.Matcher, [])
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link children, opts
  end
end
