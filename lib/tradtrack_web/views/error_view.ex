defmodule TradtrackWeb.ErrorView do
  use TradtrackWeb, :view

  # import only the function tranvers_errors/2
  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  # if result is changeset
  def render("400.json", %{result: %Changeset{} = changeset}) do
    %{
      message: translate_errors(changeset)
    }
  end

  # otherwise
  def render("400.json", %{result: message}) do
    %{
      message: message
    }
  end

  defp translate_errors(changeset) do
    # traverse_errors(changeset) is a default Ecto function to
    # convert errors into more readable and user-friently messages

    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
