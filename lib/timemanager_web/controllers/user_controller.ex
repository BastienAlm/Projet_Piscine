defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller

  import Ecto.Query
  import Plug.Crypto
  alias JsonWebToken.Jwt
  alias Bcrypt.Base
  alias Timemanager.Users
  alias Timemanager.Users.User
  alias Timemanager.Repo

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do

    password = Map.get(user_params, "password")

    hash = Base.hash_password(password, Base.gen_salt(12, true))

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

    user = Users.get_user!(id)

    oldhash = user.password;

    valid = Bcrypt.verify_pass(oldpassword, oldhash);

    newhash = Bcrypt.Base.hash_password(newpassword, Base.gen_salt(12, true))


   if  valid and newpassword != ""  do

    newuser_params =  Map.merge(user_params, %{"password" => newhash})

    with {:ok, %User{} = user} <- Users.update_user(user, newuser_params) do
      render(conn, :show, user: user)
    end
    else
      if valid and newpassword == "" do

        with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
          render(conn, :show, user: user)
        end
      end
      send_resp(conn, :forbidden, "Invalid password")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def login(conn, %{"login"=>login_params}) do

    useremail = Map.get(login_params,"email")

    password = Map.get(login_params, "password")

    query = from u in User,
    where: u.email == ^useremail,
    select: u
    user = Repo.all(query)

    hash = List.last(user).password

    valid = Bcrypt.verify_pass(password, hash)

    claims = %{iss: user, exp: 1300819380, "http://example.com/is_root": true}
    key = "gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr9C"

    options = %{alg: "HS256", key: key}

    token = if valid do

     # Jwt.config_header(alg: "HS256", key: key)
      JsonWebToken.sign(claims, options)

    else
      send_resp(conn, :forbidden, "Invalid password")
    end

  text(conn, token)

  end

end
