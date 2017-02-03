defmodule App.Tweets do
  def start_link do
    Agent.start_link(fn -> %{
      :fiftynerds => fetch_user_tweets("50nerdsofgrey"),
      :phpceo => fetch_user_tweets("php_ceo")
    } end, name: __MODULE__)
  end

  def get_random(screen_name) do
    Agent.get(__MODULE__, &(Enum.random(&1)))[screen_name]
  end

  def fetch_user_tweets(screen_name) do
    fetch_tweets([screen_name: screen_name, count: 200])
  end

  defp fetch_user_tweets(screen_name, max) do
    fetch_tweets([screen_name: screen_name, count: 200, max_id: max])
  end

  defp fetch_tweets(opts) do
    current_batch = ExTwitter.user_timeline(opts)
    last_id = List.last(current_batch).id
    tweets = Enum.map(current_batch, &(&1.text))

    if length(current_batch) < opts[:count] do
      tweets
    else
      [ tweets | fetch_user_tweets(opts[:screen_name], List.last(current_batch).id) ]
    end
  end
end
