defmodule TimemanagerWeb.WorktimeJSON do
  alias Timemanager.Worktimes.Worktime

  @doc """
  Renders a list of worktimes.
  """
  def index(%{worktimes: worktimes}) do
    %{data: for(worktime <- worktimes, do: data(worktime))}
  end

  @doc """
  Renders a single worktime.
  """
  def show(%{worktime: worktime}) do
    %{data: data(worktime)}
  end

  defp data(%Worktime{} = worktime) do
    %{
      id: worktime.id,
      start: worktime.start,
      end: worktime.end,
      user: worktime.user
    }
  end
end
