defmodule Tradtrack.Projects.Create do
  alias Tradtrack.{Repo, Project}

  def call(params) do
    Repo.insert(Project.changeset(params))
  end
end
