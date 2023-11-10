defmodule Timemanager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :teamname, :string
      add :teamlead, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
