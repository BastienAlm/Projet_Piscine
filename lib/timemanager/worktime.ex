defmodule Timemanager.Worktime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "worktimes" do
    field :start, :naive_datetime
    field :user, :integer
    field :end, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(worktime, attrs) do
    worktime
    |> cast(attrs, [:start, :end, :user])
    |> validate_required([:start, :end, :user])
  end
end
