defmodule TimeManager.WorktimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Worktimes` context.
  """

  @doc """
  Generate a worktime.
  """
  def worktime_fixture(attrs \\ %{}) do
    {:ok, worktime} =
      attrs
      |> Enum.into(%{
        end: ~N[2023-10-24 08:15:00],
        start: ~N[2023-10-24 08:15:00]
      })
      |> TimeManager.Worktimes.create_worktime()

    worktime
  end
end
