defmodule TradtrackWeb.ProjectsView do
  alias Tradtrack.Project

  def render("create.json", %{project: %Project{id: id} = project}) do
    %{
      message: "Project created successfully",
      project_id: id,
      project: project
    }
  end

  def render("delete.json", %{project: %Project{id: id}}) do
    %{
      message: "Project deleted successfully",
      project: %{
        id: id
      }
    }
  end
end
