defmodule TradtrackWeb.UsersController do
  use TradtrackWeb, :controller

  alias Tradtrack.User

  action_fallback TradtrackWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Tradtrack.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
