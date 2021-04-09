defmodule TradtrackWeb.Router do
  use TradtrackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    # aqui por exemplo poderia criar um plug de autenticação
  end

  scope "/api", TradtrackWeb do
    pipe_through :api

    # User
    post "/users", UsersController, :create
    delete "/users/:id", UsersController, :delete
    patch "/users/:id", UsersController, :update

    # Project
    post "/projects", ProjectsController, :create
    delete "/projects/:id", ProjectsController, :delete
    patch "/projects/:id", ProjectsController, :update
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TradtrackWeb.Telemetry
    end
  end
end
