defmodule Tradtrack.Repo do
  use Ecto.Repo,
    otp_app: :tradtrack,
    adapter: Ecto.Adapters.Postgres
end
