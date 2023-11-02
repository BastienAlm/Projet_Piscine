defmodule TimemanagerWeb.WorkingtimeController do
  use TimemanagerWeb, :controller

  import Ecto.Query
  alias Timemanager.Workingtimes
  alias Timemanager.Workingtimes.Workingtime
  alias Timemanager.Clocks.Clock
  alias Timemanager.Repo

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Workingtimes.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => userID, "workingtime" => workingtime_params}) do


    query = from u in Clock,
      where: u.user == ^userID,
      select: u

    clock= Repo.all(query)
    status =  List.last(clock).status
    count = length(clock)
    clockout = "1000-01-01T00:00:00"
    clockin = if status == true do
                clockin = List.last(clock).time
               else
                clockin =  Enum.at(clock, count-2).time
             end
    newworkingtime = Map.merge(workingtime_params, %{"start" => clockin, "end" => clockout , "user" => userID})

    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(newworkingtime) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime}")
      |> render(:shows, workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userID}) do

    query =
      from u in Workingtime,
      where: u.user == ^userID,
      select: u
    workingtime = Repo.all(query)
    render(conn, :show, workingtime: workingtime)
  end

  def showbyid(conn, %{"userID" => userID, "id" => id}) do

    query =
      from u in Workingtime,
      where: u.user == ^userID and u.id == ^id,
      select: u
    workingtimes = Repo.all(query)

    render(conn, :index, workingtimes: workingtimes)

  end

  def update(conn, %{"userID" => userID, "workingtime" => workingtime_params}) do

    query = from u in Clock,
      where: u.user == ^userID,
      select: u

    clock= Repo.all(query)
    status =  List.last(clock).status
    count = length(clock)

    clockout = if status == false do
      clockout = List.last(clock).time
     else
      clockout =  Enum.at(clock, count-2).time
   end

   query = from u in Workingtime,
      where: u.user == ^userID,
      select: u

    workingtime = Repo.all(query)

    newworkingtime = List.last(workingtime)

    updateworkingtime = Map.merge(workingtime_params, %{"end" => clockout}); # clock out by update

    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.update_workingtime(newworkingtime, updateworkingtime) do
      render(conn, :shows, workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
