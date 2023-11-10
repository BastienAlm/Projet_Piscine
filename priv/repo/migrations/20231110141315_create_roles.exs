defmodule Timemanager.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :rolename, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
    create unique_index(:roles, [:rolename])

  end
end
