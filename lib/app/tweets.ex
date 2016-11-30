defmodule App.Tweets do
  use GenServer
  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> [DateTime.utc_now] end, name: @name)
    add_tweets(fetch_from_twitter)
  end

  def get_random do
    Agent.get(@name, &(Enum.random(tl(&1))))
  end

  def fetch_from_twitter() do
    opts = [screen_name: "50nerdsofgrey", count: 200]
    current_batch = ExTwitter.user_timeline(opts)

    if length(current_batch) < 200 do
      (current_batch |> Enum.map(&(&1.text)))
    else
      (current_batch |> Enum.map(&(&1.text))) ++ fetch_from_twitter(List.last(current_batch).id)
    end
  end

  defp fetch_from_twitter(max) do
    opts = [screen_name: "50nerdsofgrey", count: 200, max_id: max]
    current_batch = ExTwitter.user_timeline(opts)

    if length(current_batch) < 200 do
      (current_batch |> Enum.map(&(&1.text)))
    else
      (current_batch |> Enum.map(&(&1.text))) ++ fetch_from_twitter(List.last(current_batch).id)
    end
  end

  defp add_tweets(tweets) do
    Agent.update(@name, &do_add_tweets(&1, tweets))
  end

  defp get_size do
    Agent.get(@name, &(length(&1) - 1))
  end

  defp do_add_tweets(list, tweets) do
    list ++ tweets
  end

  defp get_last_update_time do
    Agent.get(@name, &(hd(&1)))
  end
end
