defmodule App.Quote do
  use Ecto.Schema

  schema "quotes" do
    field :message, :string
    field :author, :string
  end
end
