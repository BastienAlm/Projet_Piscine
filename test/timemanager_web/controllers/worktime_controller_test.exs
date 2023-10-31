defmodule TimemanagerWeb.WorktimeControllerTest do
  use TimemanagerWeb.ConnCase

  import Timemanager.WorktimesFixtures

  alias Timemanager.Worktimes.Worktime

  @create_attrs %{
    start: ~N[2023-10-29 06:31:00],
    user: 42,
    end: ~N[2023-10-29 06:31:00]
  }
  @update_attrs %{
    start: ~N[2023-10-30 06:31:00],
    user: 43,
    end: ~N[2023-10-30 06:31:00]
  }
  @invalid_attrs %{start: nil, user: nil, end: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all worktimes", %{conn: conn} do
      conn = get(conn, ~p"/api/worktimes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create worktime" do
    test "renders worktime when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/worktimes", worktime: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/worktimes/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2023-10-29T06:31:00",
               "start" => "2023-10-29T06:31:00",
               "user" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/worktimes", worktime: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update worktime" do
    setup [:create_worktime]

    test "renders worktime when data is valid", %{conn: conn, worktime: %Worktime{id: id} = worktime} do
      conn = put(conn, ~p"/api/worktimes/#{worktime}", worktime: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/worktimes/#{id}")

      assert %{
               "id" => ^id,
               "end" => "2023-10-30T06:31:00",
               "start" => "2023-10-30T06:31:00",
               "user" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, worktime: worktime} do
      conn = put(conn, ~p"/api/worktimes/#{worktime}", worktime: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete worktime" do
    setup [:create_worktime]

    test "deletes chosen worktime", %{conn: conn, worktime: worktime} do
      conn = delete(conn, ~p"/api/worktimes/#{worktime}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/worktimes/#{worktime}")
      end
    end
  end

  defp create_worktime(_) do
    worktime = worktime_fixture()
    %{worktime: worktime}
  end
end
