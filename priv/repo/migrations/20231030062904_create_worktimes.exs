defmodule Timemanager.Repo.Migrations.CreateWorktimes do
  use Ecto.Migration

  def change do
    create table(:worktimes) do
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :user, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
