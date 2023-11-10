defmodule Timemanager.PlugAuthenticate do
  import Plug.Conn
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Joken.Signer.verify(token, Joken.Signer.create("HS256", "32aUJJ6sg18Habq7PfISeAIuww5d+S6x5V5XawBMRg4fPgn2TqvachtuJa5JTYR8")) do
         # IO.inspect(conn)
      conn
      |> assign(:current_user, Timemanager.Users.get_user!(Map.get(data, "user_id")))


    else
      error -> nil
        conn
        |> put_status(403)
        |> send_resp(:unauthorized, "Invalid credentials")
        |> halt()
    end
  end

end
