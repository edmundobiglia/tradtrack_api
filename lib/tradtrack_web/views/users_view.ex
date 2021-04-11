defmodule TradtrackWeb.UsersView do
  alias Tradtrack.User

  def render(
        "create.json",
        %{
          user: %User{id: id, name: name, last_name: last_name, nickname: nickname},
          token: token
        }
      ) do
    %{
      message: "User created successfully.",
      token: token,
      user: %{
        id: id,
        name: name,
        last_name: last_name,
        nickname: nickname
      }
    }
  end

  def render(
        "delete.json",
        %{user: %User{id: id}}
      ) do
    %{
      message: "User deleted successfully.",
      user: %{id: id}
    }
  end

  def render("update.json", %{user: %User{} = user}) do
    %{
      message: "User updated successfully.",
      user: user
    }
  end

  def render("authenticate.json", %{user: %User{id: id, email: email}, token: token}) do
    %{
      message: "User authenticated successfully.",
      user: %{id: id, email: email},
      token: token
    }
  end
end
