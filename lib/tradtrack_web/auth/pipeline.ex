defmodule TradtrackWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :tradtrack,
    module: TradtrackWeb.Auth.Guardian,
    error_handler: TradtrackWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
