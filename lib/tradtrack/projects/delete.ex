defmodule Tradtrack.Projects.Delete do
  alias Tradtrack.{Project, Repo}

  def call(id) do
    project = Repo.get(Project, id)

    Repo.delete(project)
  end
end
