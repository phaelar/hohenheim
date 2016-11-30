defmodule App do
  use Application
  require Logger

  def get_tweets() do
    Logger.log :info, "0"
    opts = [screen_name: "50nerdsofgrey", count: 200]
    current_batch = ExTwitter.user_timeline(opts)

    if length(current_batch) < 200 do
      (current_batch |> Enum.map(&(&1.text)))
    else
      (current_batch |> Enum.map(&(&1.text))) ++ get_tweets(List.last(current_batch).id)
    end
  end

  defp get_tweets(max) do
    opts = [screen_name: "50nerdsofgrey", count: 200, max_id: max]
    current_batch = ExTwitter.user_timeline(opts)

    if length(current_batch) < 200 do
      (current_batch |> Enum.map(&(&1.text)))
    else
      (current_batch |> Enum.map(&(&1.text))) ++ get_tweets(List.last(current_batch).id)
    end
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    App.Tweets.start_link

    children = [
      worker(App.Poller, []),
      worker(App.Matcher, [])
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link children, opts
  end
end
