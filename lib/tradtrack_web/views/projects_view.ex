defmodule TradtrackWeb.ProjectsView do
  alias Tradtrack.Project

  def render("created.json", %{project: %Project{} = project}) do
    %{
      message: "Project created successfully",
      project: project
    }
  end
end
