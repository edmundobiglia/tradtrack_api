defmodule TradtrackWeb.UsersView do
  alias Tradtrack.User

  def render(
        "create.json",
        %{
          user: %User{id: id, name: name, last_name: last_name, nickname: nickname}
        }
      ) do
    %{
      message: "User created successfully.",
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
        %{
          user: %User{id: id, name: name, last_name: last_name, nickname: nickname}
        }
      ) do
    %{
      message: "User created successfully.",
      user: %{
        id: id,
        name: name,
        last_name: last_name,
        nickname: nickname
      }
    }
  end
end
