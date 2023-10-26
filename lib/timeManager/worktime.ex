defmodule TimeManager.Worktime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :start, :naive_datetime
    field :end, :naive_datetime
    field :user, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(worktime, attrs) do
    worktime
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end, :user])
  end
end
