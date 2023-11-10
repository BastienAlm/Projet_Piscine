defmodule Timemanager.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :description, :string
    field :rolename, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:rolename, :description])
    |> validate_required([:rolename, :description])
    |> unique_constraint(:rolename)
  end
end
