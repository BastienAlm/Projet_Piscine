defmodule TimeManagerWeb.WorktimeControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.WorktimesFixtures

  alias TimeManager.Worktimes.Worktime

  @create_attrs %{
    start: ~N[2023-10-24 08:15:00],
    end: ~N[2023-10-24 08:15:00]
  }
  @update_attrs %{
    start: ~N[2023-10-25 08:15:00],
    end: ~N[2023-10-25 08:15:00]
  }
  @invalid_attrs %{start: nil, end: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workingtimes", %{conn: conn} do
      conn = get(conn, ~p"/api/workingtimes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create worktime" do
    test "renders worktime when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/workingtimes", worktime: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/workingtimes/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2023-10-24T08:15:00",
               "start" => "2023-10-24T08:15:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/workingtimes", worktime: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update worktime" do
    setup [:create_worktime]

    test "renders worktime when data is valid", %{conn: conn, worktime: %Worktime{id: id} = worktime} do
      conn = put(conn, ~p"/api/workingtimes/#{worktime}", worktime: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/workingtimes/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2023-10-25T08:15:00",
               "start" => "2023-10-25T08:15:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, worktime: worktime} do
      conn = put(conn, ~p"/api/workingtimes/#{worktime}", worktime: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete worktime" do
    setup [:create_worktime]

    test "deletes chosen worktime", %{conn: conn, worktime: worktime} do
      conn = delete(conn, ~p"/api/workingtimes/#{worktime}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/workingtimes/#{worktime}")
      end
    end
  end

  defp create_worktime(_) do
    worktime = worktime_fixture()
    %{worktime: worktime}
  end
end
