defmodule Timemanager.Worktimes do
  @moduledoc """
  The Worktimes context.
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo

  alias Timemanager.Worktimes.Worktime

  @doc """
  Returns the list of worktimes.

  ## Examples

      iex> list_worktimes()
      [%Worktime{}, ...]

  """
  def list_worktimes do
    Repo.all(Worktime)
  end

  @doc """
  Gets a single worktime.

  Raises `Ecto.NoResultsError` if the Worktime does not exist.

  ## Examples

      iex> get_worktime!(123)
      %Worktime{}

      iex> get_worktime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_worktime!(id), do: Repo.get!(Worktime, id)

  @doc """
  Creates a worktime.

  ## Examples

      iex> create_worktime(%{field: value})
      {:ok, %Worktime{}}

      iex> create_worktime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_worktime(attrs \\ %{}) do
    %Worktime{}
    |> Worktime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a worktime.

  ## Examples

      iex> update_worktime(worktime, %{field: new_value})
      {:ok, %Worktime{}}

      iex> update_worktime(worktime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_worktime(%Worktime{} = worktime, attrs) do
    worktime
    |> Worktime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a worktime.

  ## Examples

      iex> delete_worktime(worktime)
      {:ok, %Worktime{}}

      iex> delete_worktime(worktime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_worktime(%Worktime{} = worktime) do
    Repo.delete(worktime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking worktime changes.

  ## Examples

      iex> change_worktime(worktime)
      %Ecto.Changeset{data: %Worktime{}}

  """
  def change_worktime(%Worktime{} = worktime, attrs \\ %{}) do
    Worktime.changeset(worktime, attrs)
  end
end
