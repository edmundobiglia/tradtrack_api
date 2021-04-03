defmodule Tradtrack do
  alias Tradtrack.Users.Create, as: CreateUser
  alias Tradtrack.Users.Delete, as: DeleteUser
  alias Tradtrack.Users.Update, as: UpdateUser
  alias Tradtrack.Projects.Create, as: CreateProject
  alias Tradtrack.Projects.Delete, as: DeleteProject
  alias Tradtrack.Projects.Update, as: UpdateProject

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate delete_user(params), to: DeleteUser, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call

  defdelegate create_project(params), to: CreateProject, as: :call
  defdelegate delete_project(params), to: DeleteProject, as: :call
  defdelegate update_project(params), to: UpdateProject, as: :call
end
