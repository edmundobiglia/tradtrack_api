defmodule TradtrackWeb.UsersController do
  use TradtrackWeb, :controller

  alias Tradtrack.User
  alias TradtrackWeb.Auth.Guardian

  action_fallback TradtrackWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Tradtrack.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate_user(email, password) do
      conn
      |> put_status(:created)
      |> render("authenticate.json", %{user: user, token: token})
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Tradtrack.delete_user(id) do
      conn
      |> put_status(:ok)
      |> render("delete.json", user: user)
    end
  end

  def update(conn, params) do
    with {:ok, user} <- Tradtrack.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end
end
