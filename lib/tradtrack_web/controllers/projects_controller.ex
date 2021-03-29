defmodule TradtrackWeb.ProjectsController do
  use TradtrackWeb, :controller

  alias Tradtrack.Project

  action_fallback TradtrackWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Project{} = project} <- Tradtrack.create_project(params) do
      conn
      |> put_status(:created)
      |> render("created.json", project: project)
    end
  end
end
