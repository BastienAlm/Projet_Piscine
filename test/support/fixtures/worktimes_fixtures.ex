defmodule Timemanager.WorktimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Worktimes` context.
  """

  @doc """
  Generate a worktime.
  """
  def worktime_fixture(attrs \\ %{}) do
    {:ok, worktime} =
      attrs
      |> Enum.into(%{
        end: ~N[2023-10-29 06:31:00],
        start: ~N[2023-10-29 06:31:00],
        user: 42
      })
      |> Timemanager.Worktimes.create_worktime()

    worktime
  end
end
