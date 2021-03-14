defmodule Tradtrack do
  alias Tradtrack.Users.Create

  defdelegate create_user(params), to: Create, as: :call
end
