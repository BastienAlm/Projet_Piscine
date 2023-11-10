defmodule Timemanager.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string
    field :role, :string
    field :team, :string

    has_many :clocks, Timemanager.Users.User, foreign_key: :user
    has_many :workingtimes, Timemanager.Users.User, foreign_key: :user

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :role, :team])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> validate_required([:email, :username, :password])
  end
end
