defmodule Tradtrack.Projects.Create do
  alias Tradtrack.{Repo, Project}

  def call(%{
        "code" => code,
        "client" => client,
        "word_count" => word_count,
        "rate" => rate,
        "user_id" => user_id,
        "date_received" => iso_date_received,
        "delivery_date" => iso_delivery_date
      }) do
    {:ok, date_received} = Date.from_iso8601(iso_date_received)
    {:ok, delivery_date, 0} = DateTime.from_iso8601(iso_delivery_date)

    params = %{
      code: code,
      client: client,
      word_count: word_count,
      rate: rate,
      user_id: user_id,
      date_received: date_received,
      delivery_date: delivery_date
    }

    Repo.insert(Project.changeset(params))
  end
end
