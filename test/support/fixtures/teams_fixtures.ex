defmodule Timemanager.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Teams` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        teammanager: "some teammanager",
        teamname: "some teamname"
      })
      |> Timemanager.Teams.create_team()

    team
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        description: "some description",
        teamlead: "some teamlead",
        teamname: "some teamname"
      })
      |> Timemanager.Teams.create_team()

    team
  end
end
