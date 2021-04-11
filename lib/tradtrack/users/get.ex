defmodule Tradtrack.Users.Get do
  alias Tradtrack.{Repo, User}

  def call(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
