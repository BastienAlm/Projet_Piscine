defmodule TimemanagerWeb.TeamJSON do
  alias Timemanager.Teams.Team

  @doc """
  Renders a list of teams.
  """
  def index(%{teams: teams}) do
    %{data: for(team <- teams, do: data(team))}
  end

  @doc """
  Renders a single team.
  """
  def show(%{team: team}) do
    %{data: data(team)}
  end

  defp data(%Team{} = team) do
    %{
      id: team.id,
      teamname: team.teamname,
      teamlead: team.teamlead,
      description: team.description
    }
  end
end
