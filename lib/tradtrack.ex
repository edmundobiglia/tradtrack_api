defmodule Tradtrack do
  alias Tradtrack.Users.Create, as: CreateUser
  alias Tradtrack.Users.Delete, as: DeleteUser
  alias Tradtrack.Projects.Create, as: CreateProject

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate delete_user(params), to: DeleteUser, as: :call

  defdelegate create_project(params), to: CreateProject, as: :call
end
