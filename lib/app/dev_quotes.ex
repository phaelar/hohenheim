defmodule App.DevQuotes do
  def start_link do
    Agent.start_link(fn -> fetch_from_json end, name: __MODULE__)
  end

  def get_random do
    Agent.get(__MODULE__, &(Enum.random(tl(&1))))
  end

  def fetch_from_json do
    response = HTTPoison.get! "http://cdn.rawgit.com/fortrabbit/quotes/master/quotes.json"
    Enum.map Poison.decode!(response.body), &("\"#{&1["text"]}\" - #{&1["author"]}")
  end
end
