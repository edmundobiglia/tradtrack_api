defmodule Tradtrack.Projects.Update do
  alias Tradtrack.{Project, Repo}

  def call(%{"id" => id, "changes" => changes}) do
    project = Repo.get(Project, id)

    changes_with_updated_total = update_total(changes, project)

    changes_with_validated_dates = validate_dates(changes_with_updated_total, project)

    case changes_with_validated_dates do
      {:error, reason} -> {:error, reason}
      _ -> Repo.update(Project.changeset(project, changes_with_validated_dates))
    end
  end

  defp update_total(%{"word_count" => word_count, "rate" => rate} = changes, _project) do
    total = Decimal.mult(word_count, rate)

    Map.put(changes, "total", total)
  end

  defp update_total(%{"word_count" => word_count} = changes, project) do
    total = Decimal.mult(word_count, project.rate)

    Map.put(changes, "total", total)
  end

  defp update_total(%{"rate" => rate} = changes, project) do
    total = Decimal.mult(rate, project.word_count)

    Map.put(changes, "total", total)
  end

  defp update_total(changes, _project) do
    changes
  end

  defp validate_dates(
         %{"date_received" => iso_date_received, "delivery_date" => iso_delivery_date} = changes,
         _project
       ) do
    date_received = Date.from_iso8601!(iso_date_received)
    {:ok, delivery_date, _} = DateTime.from_iso8601(iso_delivery_date)

    if Date.diff(delivery_date, date_received) < 0,
      do: {:error, "Delivery date should be after date received."},
      else: changes
  end

  defp validate_dates(
         %{"date_received" => iso_date_received} = changes,
         project
       ) do
    date_received = Date.from_iso8601!(iso_date_received)
    delivery_date = project.delivery_date

    if Date.diff(delivery_date, date_received) < 0,
      do: {:error, "Delivery date should be after date received."},
      else: changes
  end

  defp validate_dates(
         %{"delivery_date" => iso_delivery_date} = changes,
         project
       ) do
    date_received = project.date_received
    {:ok, delivery_date, _} = DateTime.from_iso8601(iso_delivery_date)

    if Date.diff(delivery_date, date_received) < 0,
      do: {:error, "Delivery date should be after date received."},
      else: changes
  end

  defp validate_dates(
         %{} = changes,
         _project
       ) do
    changes
  end
end
