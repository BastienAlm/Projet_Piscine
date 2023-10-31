defmodule Timemanager.WorktimesTest do
  use Timemanager.DataCase

  alias Timemanager.Worktimes

  describe "worktimes" do
    alias Timemanager.Worktimes.Worktime

    import Timemanager.WorktimesFixtures

    @invalid_attrs %{start: nil, user: nil, end: nil}

    test "list_worktimes/0 returns all worktimes" do
      worktime = worktime_fixture()
      assert Worktimes.list_worktimes() == [worktime]
    end

    test "get_worktime!/1 returns the worktime with given id" do
      worktime = worktime_fixture()
      assert Worktimes.get_worktime!(worktime.id) == worktime
    end

    test "create_worktime/1 with valid data creates a worktime" do
      valid_attrs = %{start: ~N[2023-10-29 06:31:00], user: 42, end: ~N[2023-10-29 06:31:00]}

      assert {:ok, %Worktime{} = worktime} = Worktimes.create_worktime(valid_attrs)
      assert worktime.start == ~N[2023-10-29 06:31:00]
      assert worktime.user == 42
      assert worktime.end == ~N[2023-10-29 06:31:00]
    end

    test "create_worktime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Worktimes.create_worktime(@invalid_attrs)
    end

    test "update_worktime/2 with valid data updates the worktime" do
      worktime = worktime_fixture()
      update_attrs = %{start: ~N[2023-10-30 06:31:00], user: 43, end: ~N[2023-10-30 06:31:00]}

      assert {:ok, %Worktime{} = worktime} = Worktimes.update_worktime(worktime, update_attrs)
      assert worktime.start == ~N[2023-10-30 06:31:00]
      assert worktime.user == 43
      assert worktime.end == ~N[2023-10-30 06:31:00]
    end

    test "update_worktime/2 with invalid data returns error changeset" do
      worktime = worktime_fixture()
      assert {:error, %Ecto.Changeset{}} = Worktimes.update_worktime(worktime, @invalid_attrs)
      assert worktime == Worktimes.get_worktime!(worktime.id)
    end

    test "delete_worktime/1 deletes the worktime" do
      worktime = worktime_fixture()
      assert {:ok, %Worktime{}} = Worktimes.delete_worktime(worktime)
      assert_raise Ecto.NoResultsError, fn -> Worktimes.get_worktime!(worktime.id) end
    end

    test "change_worktime/1 returns a worktime changeset" do
      worktime = worktime_fixture()
      assert %Ecto.Changeset{} = Worktimes.change_worktime(worktime)
    end
  end
end
