defmodule App.DevQuotes do
  use GenServer
  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> [DateTime.utc_now] end, name: @name)
    add_quotes(fetch_from_json)
  end

  def get_random do
    Agent.get(@name, &(Enum.random(tl(&1))))
  end

  def fetch_from_json do
    response = HTTPoison.get! "http://cdn.rawgit.com/fortrabbit/quotes/master/quotes.json"
    Enum.map Poison.decode!(response.body), &("\"#{&1["text"]}\" - #{&1["author"]}")
  end

  defp add_quotes(quotes) do
    Agent.update(@name, &do_add_quotes(&1, quotes))
  end

  defp get_size do
    Agent.get(@name, &(length(&1) - 1))
  end

  defp do_add_quotes(list, quotes) do
    list ++ quotes
  end

  defp get_last_update_time do
    Agent.get(@name, &(hd(&1)))
  end
end
