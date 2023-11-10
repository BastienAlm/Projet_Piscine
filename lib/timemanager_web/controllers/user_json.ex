defmodule TimemanagerWeb.UserJSON do
  alias Timemanager.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end
  def sign(%{token: jwt}) do
    %{token: jwt}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      username: user.username,
      role: user.role,
      team: user.team,
      password: user.password
    }
  end
end
