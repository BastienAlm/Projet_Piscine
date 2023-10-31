defmodule TimemanagerWeb.WorktimeController do
  use TimemanagerWeb, :controller

  alias Ecto.Query
  alias Timemanager.Worktimes
  alias Timemanager.Worktimes.Worktime
  alias Timemanager.Clocks


  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    worktimes = Worktimes.list_worktimes()
    render(conn, :index, worktimes: worktimes)
  end

  def create(conn, %{"userID" =>userID, "worktime" => worktime_params}) do

    currentTime = DateTime.utc_now();

    # clock = Ecto.Query.by_fields(Clocks, user: userID) |> Repo.all

    # #clock = Timemanager.get_by(Clocks, user: userID);

    # text(conn, clock)

    worktimenew = Map.merge(worktime_params, %{"start" => currentTime, "user" => userID, "end" => DateTime.add(currentTime, 28800, :second)});

    with {:ok, %Worktime{} = worktime} <- Worktimes.create_worktime(worktimenew) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/worktimes/#{worktime}")
      |> render(:show, worktime: worktime)
    end
  end

  def show(conn, %{"id" => id}) do
    worktime = Worktimes.get_worktime!(id)
    render(conn, :show, worktime: worktime)
  end

  def update(conn, %{"id" => id, "worktime" => worktime_params}) do
    worktime = Worktimes.get_worktime!(id)

    with {:ok, %Worktime{} = worktime} <- Worktimes.update_worktime(worktime, worktime_params) do
      render(conn, :show, worktime: worktime)
    end
  end

  def delete(conn, %{"id" => id}) do
    worktime = Worktimes.get_worktime!(id)

    with {:ok, %Worktime{}} <- Worktimes.delete_worktime(worktime) do
      send_resp(conn, :no_content, "")
    end
  end
end
