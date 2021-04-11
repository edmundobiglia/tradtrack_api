# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tradtrack,
  ecto_repos: [Tradtrack.Repo]

# Configures the endpoint
config :tradtrack, TradtrackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i4cESJjE6gIpYJ0K2LOVHzsvz4wmJYUQY9P01UoUbwfiwBCu92tzMGRpShc0wyaF",
  render_errors: [view: TradtrackWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Tradtrack.PubSub,
  live_view: [signing_salt: "L7kBr147"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :tradtrack, Tradtrack.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :tradtrack, TradtrackWeb.Auth.Guardian,
  issuer: "tradtrack",
  secret_key: "Klg7WoMUewMNqSJ4pgSA8VQCEaTagperDegS+NEPhlsjOEwNHIgyyfoJQiGamTaX"
