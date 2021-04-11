defmodule TradtrackWeb.Auth.Guardian do
  use Guardian, otp_app: :tradtrack

  alias Tradtrack.{Repo, User}

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Repo.get(User, id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def authenticate_user(email, password) do
    with {:ok, user} <- Tradtrack.get_user(email) do
      case verify_password(password, user.password_hash) do
        true -> create_token(user)
        false -> {:error, :unauthorized}
      end
    end
  end

  defp verify_password(password, password_hash) do
    Bcrypt.verify_pass(password, password_hash)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
