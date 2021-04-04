defmodule Tradtrack.Projects.Create do
  alias Tradtrack.{Project, Repo}

  def call(%{"word_count" => word_count, "rate" => rate} = params) do
    total = word_count * rate

    updated_params = Map.put(params, "total", total)

    Repo.insert(Project.changeset(updated_params))
  end
end
