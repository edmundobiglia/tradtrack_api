defmodule Tradtrack.Users.Update do
  alias Tradtrack.{User, Repo}

  def call(%{"id" => id, "changes" => changes}) do
    user = Repo.get(User, id)

    user
    |> User.update_changeset(changes)
    |> Repo.update()
  end
end
