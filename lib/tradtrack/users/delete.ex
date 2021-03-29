defmodule Tradtrack.Users.Delete do
  alias Ecto.Multi

  alias Tradtrack.{Repo, User}

  def call(id) do
    Multi.new()
    |> Multi.delete(:user, Repo.get(User, id))
    |> Repo.transaction()
  end
end
