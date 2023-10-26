defmodule TimeManagerWeb.WorktimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.Account
  alias TimeManager.Account.User
  alias TimeManager.Worktimes
  alias TimeManager.Worktimes.Worktime
  #import Ecto.Query, warn: false
  alias TimeManager.Repo

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Worktimes.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"userID"=>userID, "worktime" => worktime_params}) do

   # user = Account.get_user!(userID)
    user = Repo.get_by(User, id: userID)

    #worktime1 = Map.put(worktime_params, "user",   user) #Map.merge(worktime_params, %{"user" => user}) # Map.put(worktime_params, "user", userID)
      with {:ok, %Worktime{} = worktime} <- Worktimes.create_worktime(worktime_params) do
        worktimeid = Worktimes.get_worktime!(worktime.id)
        with {:ok, %Worktime{} = worktime1} <- Worktimes.update_worktime(worktimeid, %{"user"=>userID}) do
          conn
          |> text(worktime1)
          # |> put_status(:created)
          # |> put_resp_header("location", ~p"/api/workingtimes/#{worktime1}")
          # |> render(:show, worktime: worktime1)
        end
      end

  end

  def show(conn, %{"id" => id}) do
    worktime = Worktimes.get_worktime!(id)
    render(conn, :show, worktime: worktime)
  end

  def getWorktimeByUserId(conn, %{"userID" => userID}) do
    text(conn, userID)


    worktime = Repo.get_by(Worktime, user: userID)
    #render(conn, :show, worktime: worktime)
    # q = Query.new()
    # |> Query.select("*")
    # |> Query.from("users")

    # q = case userID == nil do
    #   true -> q
    #   false -> Query.where(q, "userID", :eq, userID)
    # end
    #render(conn, :show, worktime: q)

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
