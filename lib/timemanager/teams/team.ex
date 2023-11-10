defmodule Timemanager.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :description, :string
    field :teamname, :string
    field :teamlead, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:teamname, :teamlead, :description])
    |> validate_required([:teamname, :teamlead, :description])
  end
end
