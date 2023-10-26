defmodule TimeManager.WorktimesTest do
  use TimeManager.DataCase

  alias TimeManager.Worktimes

  describe "workingtimes" do
    alias TimeManager.Worktimes.Worktime

    import TimeManager.WorktimesFixtures

    @invalid_attrs %{start: nil, end: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      worktime = worktime_fixture()
      assert Worktimes.list_workingtimes() == [worktime]
    end

    test "get_worktime!/1 returns the worktime with given id" do
      worktime = worktime_fixture()
      assert Worktimes.get_worktime!(worktime.id) == worktime
    end

    test "create_worktime/1 with valid data creates a worktime" do
      valid_attrs = %{start: ~N[2023-10-24 08:15:00], end: ~N[2023-10-24 08:15:00]}

      assert {:ok, %Worktime{} = worktime} = Worktimes.create_worktime(valid_attrs)
      assert worktime.start == ~N[2023-10-24 08:15:00]
      assert worktime.end == ~N[2023-10-24 08:15:00]
    end

    test "create_worktime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Worktimes.create_worktime(@invalid_attrs)
    end

    test "update_worktime/2 with valid data updates the worktime" do
      worktime = worktime_fixture()
      update_attrs = %{start: ~N[2023-10-25 08:15:00], end: ~N[2023-10-25 08:15:00]}

      assert {:ok, %Worktime{} = worktime} = Worktimes.update_worktime(worktime, update_attrs)
      assert worktime.start == ~N[2023-10-25 08:15:00]
      assert worktime.end == ~N[2023-10-25 08:15:00]
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
