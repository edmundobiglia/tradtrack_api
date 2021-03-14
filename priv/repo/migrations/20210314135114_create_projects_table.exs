defmodule Tradtrack.Repo.Migrations.CreateProjectsTable do
  use Ecto.Migration

  def change do

    create table :projects do
      add :code, :string
      add :client, :string
      add :word_count, :integer
      add :rate, :decimal
      add :total, :decimal
      add :date_received, :date
      add :delivery_date, :utc_datetime
      add :delivery_status, :boolean, default: false
      add :payment_status, :boolean, default: false
      add :notes, :string, default: ""
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create constraint(:projects, :word_count_must_be_greater_than_zero, check: "word_count > 0")
    create constraint(:projects, :rate_must_be_greater_than_zero, check: "rate > 0")
  end
end
