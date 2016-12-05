defmodule App.Repo.Migrations.CreateQuotesTable do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :message, :string
      add :author, :string
    end
  end
end
