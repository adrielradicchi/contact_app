defmodule ContactApp.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :phone, :string

      timestamps()
    end

    create unique_index(:contacts, [:email])
  end
end
