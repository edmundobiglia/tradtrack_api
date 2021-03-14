defmodule TradtrackWeb.FallbackController do
  use TradtrackWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(TradtrackWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
