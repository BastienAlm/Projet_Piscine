defmodule Timemanager.RolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Roles` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        description: "some description",
        rolename: "some rolename"
      })
      |> Timemanager.Roles.create_role()

    role
  end
end
