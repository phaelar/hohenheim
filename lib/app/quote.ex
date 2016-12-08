defmodule App.Quote do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]
  import Ecto.Query, only: [from: 2]

  alias App.Quote
  alias App.Repo

  schema "quotes" do
    field :message, :string
    field :author, :string
  end

  @required_fields ["message", "author"]

  def insert_quote(%{} = quote) do
    %Quote{}
    |> cast(quote, @required_fields)
    |> Repo.insert
  end

  def delete_quote(quote_id) do
    get_quote(quote_id)
    |> Repo.delete
  end

  def get_quote(quote_id) do
    Repo.get!(Quote, quote_id)
  end

  def get_quotes do
    query = from q in Quote,
      select: {q.message}

    query
    |> Repo.all
  end

  def get_random do
    query = from q in Quote,
      order_by: fragment("RANDOM()"),
      limit: 1,
      select: {q.message, q.author}

    query
    |> Repo.one
  end
end
