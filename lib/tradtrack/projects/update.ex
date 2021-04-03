defmodule Tradtrack.Projects.Update do
  alias Tradtrack.{Project, Repo}

  def call(%{"id" => id, "changes" => changes}) do
    project = Repo.get(Project, id)

    project
    |> Project.changeset(changes)
    |> Repo.update()
  end
end
