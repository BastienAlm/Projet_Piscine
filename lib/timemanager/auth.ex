defmodule Timemanager.PlugAuthenticate do
  import Plug.Conn
  require Logger

  alias Timemanager.Users


  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Joken.Signer.verify(token, Joken.Signer.create("HS256", "gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr9C")) do
      conn
      |> assign(:current_user, Timemanager.Users.get_user!(Map.get(data, "user_id")))
    else
      error ->
        conn

        |> put_status(:unauthorized)
        |> send_resp(:unauthorized, "Invalid credentials")
        |> halt()
    end
  end
end
