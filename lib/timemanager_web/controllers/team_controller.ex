defmodule TimemanagerWeb.TeamController do
  use TimemanagerWeb, :controller

  alias Timemanager.Teams
  alias Timemanager.Teams.Team
  alias Timemanager.Users

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, :index, teams: teams)
  end

  def create(conn, %{"team" => team_params}) do

    teamlead = Users.get_user!(Map.get(team_params,"teamlead"))

    newteam_params = Map.merge(team_params, %{"teamlead" => teamlead.email})

    with {:ok, %Team{} = team} <- Teams.create_team(newteam_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/teams/#{team}")
      |> render(:show, team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    render(conn, :show, team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do

    team = Teams.get_team!(id)

    teamlead = if Map.get(team_params, "teamlead") !== nil do
       Users.get_user!(Map.get(team_params,"teamlead")).email
    else
      team.teamlead
    end

    newteam_params = Map.merge(team_params, %{"teamlead" => teamlead})

    with {:ok, %Team{} = team} <- Teams.update_team(team, newteam_params) do
      render(conn, :show, team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{}} <- Teams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
