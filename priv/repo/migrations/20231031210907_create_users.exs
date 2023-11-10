defmodule Timemanager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :password, :string
      add :role, :string
      add :team, :string


      timestamps(type: :utc_datetime)


    end
    create unique_index(:users, [:email])
  end
end
