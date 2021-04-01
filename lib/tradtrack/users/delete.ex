defmodule Tradtrack.Users.Delete do
  alias Tradtrack.{Repo, User}

  def call(id) do
    user = Repo.get(User, id)

    Repo.delete(user)
  end
end
