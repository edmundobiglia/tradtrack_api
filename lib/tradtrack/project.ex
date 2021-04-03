defmodule Tradtrack.Project do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  alias Tradtrack.User

  @derive {Jason.Encoder,
           only: [
             :code,
             :client,
             :word_count,
             :rate,
             :date_received,
             :delivery_date,
             :delivery_status,
             :payment_status,
             :notes,
             :user_id
           ]}

  @primary_key {:id, :binary_id, autogenerate: true}

  @foreign_key_type :binary_id

  @allowed [
    :code,
    :client,
    :word_count,
    :rate,
    :date_received,
    :delivery_date,
    :delivery_status,
    :payment_status,
    :notes,
    :user_id
  ]

  @required_fields [:code, :client, :word_count, :rate, :date_received, :delivery_date, :user_id]

  schema "projects" do
    field :code, :string
    field :client, :string
    field :word_count, :integer
    field :rate, :decimal
    field :total, :decimal
    field :date_received, :date
    field :delivery_date, :utc_datetime
    field :delivery_status, :boolean, default: false
    field :payment_status, :boolean, default: false
    field :notes, :string, default: ""
    belongs_to :user, User
    timestamps()
  end

  def changeset(project \\ %__MODULE__{}, params) do
    project
    |> cast(params, @allowed)
    |> validate_required(@required_fields)
    |> check_constraint(:word_count, name: :word_count_must_be_greater_than_zero)
    |> check_constraint(:rate, name: :rate_must_be_greater_than_zero)
    |> validate_delivery_date()
    |> calculate_total()
  end

  defp validate_delivery_date(
         %Changeset{
           valid?: true,
           changes: %{date_received: date_received, delivery_date: delivery_date}
         } = changeset
       ) do
    case Date.diff(delivery_date, date_received) < 0 do
      true ->
        add_error(
          changeset,
          :invalid_delivery_date,
          "Delivery date must be after date received."
        )

      false ->
        changeset
    end
  end

  # defp validate_delivery_date(
  #        %Changeset{
  #          valid?: true,
  #          changes: %{}
  #        } = changeset
  #      ) do
  #   changeset
  # end

  defp calculate_total(
         %Changeset{valid?: true, changes: %{word_count: word_count, rate: rate}} = changeset
       ) do
    total = Decimal.mult(word_count, rate)

    change(changeset, %{total: total})
  end

  # defp calculate_total(%Changeset{valid?: true, changes: %{}} = changeset) do
  #   changeset
  # end
end
