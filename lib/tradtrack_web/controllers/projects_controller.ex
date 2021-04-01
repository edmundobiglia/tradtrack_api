defmodule TradtrackWeb.ProjectsController do
  use TradtrackWeb, :controller

  alias Tradtrack.Project

  action_fallback TradtrackWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Project{} = project} <- Tradtrack.create_project(params) do
      conn
      |> put_status(:created)
      |> render("create.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Project{} = project} <- Tradtrack.delete_project(id) do
      conn
      |> put_status(:ok)
      |> render("delete.json", project: project)
    end
  end
end
