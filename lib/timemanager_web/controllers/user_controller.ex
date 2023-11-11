defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller

  import Ecto.Query
  alias Pbkdf2
  alias Timemanager.Users
  alias Timemanager.Users.User
  alias Timemanager.Roles.Role
  alias Timemanager.Repo

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do

    password = Map.get(user_params, "password")

    hash = Pbkdf2.Base.hash_password(password, Pbkdf2.Base.gen_salt(salt_len: 50), [:hex])

    newuser_params = Map.merge(user_params, %{ "password" => hash})

    with {:ok, %User{} = user} <- Users.create_user(newuser_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do

    oldpassword = Map.get(user_params, "oldpassword")
    newpassword  = Map.get(user_params, "newpassword")

    with  user <- Users.get_user!(id), true <- Pbkdf2.verify_pass(oldpassword, user.password) do
      newhash = Pbkdf2.Base.hash_password(newpassword, Pbkdf2.Base.gen_salt(salt_len: 50), [:hex])
      if newpassword != "" do
        newuser_params =  Map.merge(user_params, %{"password" => newhash})

        {:ok, user} = Users.update_user(user, newuser_params)
          render(conn, :show, user: user)
      else
         {:ok, user} = Users.update_user(user, user_params)
          render(conn, :show, user: user)
      end
    else
     _err -> false
      send_resp(conn, :forbidden, "Invalid password")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"email"=>useremail, "password" => password}) do

    query = from u in User,
    where: u.email == ^useremail,
    select: u

    with user <-  Repo.one(query), true <-  Pbkdf2.verify_pass(password, user.password) do  ##view all and one

      currentTime = Joken.CurrentTime.OS.current_time

      claims = %{user_id: user.id, role: user.role , exp: currentTime + 30 * 24 * 60 * 60, iat: currentTime}

      {:ok, jwt} =  Joken.Signer.sign(claims, Joken.Signer.create("HS256", "32aUJJ6sg18Habq7PfISeAIuww5d+S6x5V5XawBMRg4fPgn2TqvachtuJa5JTYR8"))

      token = %{"token" => jwt, "user_id" => user.id, "user_role" => user.role}

      conn |> render( :sign, token: token)

    else
      false ->
      send_resp(conn, :forbidden, "Invalid password")

    end

  end

  def current(conn, _ids) do
    IO.inspect(conn)
  end



end
