defmodule Timemanager.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :role, :string
    field :email, :string
    field :password, :string
    has_many :clocks, Timemanager.Users.User, foreign_key: :user
    has_many :workingtimes, Timemanager.Users.User, foreign_key: :user

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :role, :password])
    |> unique_constraint(:email)
    |> validate_required([:email, :username, :role, :password])
  end
end
