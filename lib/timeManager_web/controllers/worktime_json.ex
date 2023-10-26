defmodule TimeManagerWeb.WorktimeJSON do
  alias TimeManager.Worktimes.Worktime

  @doc """
  Renders a list of workingtimes.
  """
  def index(%{workingtimes: workingtimes}) do
    %{data: for(worktime <- workingtimes, do: data(worktime))}
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
      user: worktime.user,
    }
  end
end
