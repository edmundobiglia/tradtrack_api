defmodule Tradtrack.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do

    create table :users do
      add :name, :string
      add :last_name, :string
      add :email, :string
      add :nickname, :string
      add :password_hash, :string

      timestamps()
    end

    # ensures fields email and nickname are unique
    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end
