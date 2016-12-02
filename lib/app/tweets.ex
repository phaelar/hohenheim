defmodule App.Tweets do
  def start_link do
    Agent.start_link(fn -> fetch_from_twitter end, name: __MODULE__)
  end

  def get_random do
    Agent.get(__MODULE__, &(Enum.random(tl(&1))))
  end

  defp fetch_from_twitter() do
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
end
