defmodule Tradtrack.Users.Create do
  alias Tradtrack.{User, Repo}

  def call(params) do
    Repo.insert(User.changeset(params))
  end
end
