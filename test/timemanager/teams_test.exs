defmodule Timemanager.TeamsTest do
  use Timemanager.DataCase

  alias Timemanager.Teams

  describe "teams" do
    alias Timemanager.Teams.Team

    import Timemanager.TeamsFixtures

    @invalid_attrs %{description: nil, teamname: nil, teamlead: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Teams.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Teams.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{description: "some description", teamname: "some teamname", teamlead: "some teamlead"}

      assert {:ok, %Team{} = team} = Teams.create_team(valid_attrs)
      assert team.description == "some description"
      assert team.teamname == "some teamname"
      assert team.teamlead == "some teamlead"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teams.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{description: "some updated description", teamname: "some updated teamname", teamlead: "some updated teamlead"}

      assert {:ok, %Team{} = team} = Teams.update_team(team, update_attrs)
      assert team.description == "some updated description"
      assert team.teamname == "some updated teamname"
      assert team.teamlead == "some updated teamlead"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Teams.update_team(team, @invalid_attrs)
      assert team == Teams.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Teams.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Teams.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Teams.change_team(team)
    end
  end
end
