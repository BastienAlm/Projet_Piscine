defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller

  import Ecto.Query
  alias Timemanager.Clocks
  alias Timemanager.Clocks.Clock
  alias Timemanager.Repo

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"userID" => userID, "clock" => clock_params}) do

    currentTime = DateTime.utc_now();

    newclock = Map.merge(clock_params, %{"time" => currentTime, "user" => userID, "status" => "true"}); # clock out by update

     with {:ok, %Clock{} = clock} <- Clocks.create_clock(newclock) do
       conn
       |> put_status(:created)
       |> put_resp_header("location", ~p"/api/clocks/#{clock}")
       |> render(:shows, clock: clock)
     end
   end

  def show(conn, %{"userID" => userID}) do

    query =
      from u in Clock,
      where: u.user == ^userID,
      select: u
    clock = Repo.all(query)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
