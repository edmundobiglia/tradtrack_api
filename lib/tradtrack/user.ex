defmodule Tradtrack.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  alias Tradtrack.Project

  @derive {Jason.Encoder,
           only: [
             :name,
             :last_name,
             :email,
             :nickname,
             :password,
             :password_hash
           ]}

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :last_name, :email, :nickname]

  @email_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

  schema "users" do
    field :name, :string
    field :last_name, :string
    field :email, :string
    field :nickname, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :projects, Project

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> validate_format(:email, @email_regex)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
