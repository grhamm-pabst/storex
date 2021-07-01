defmodule StorexWeb.ClientsController do
  use StorexWeb, :controller

  alias StorexWeb.Auth.Guardian, as: AuthGuardian

  alias StorexWeb.FallbackController

  action_fallback FallbackController

  def sign_in(conn, %{"email" => _email, "password" => _password} = params) do
    with {:ok, token, client} <- AuthGuardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", client: client, token: token)
    end
  end
end
