defmodule StorexWeb.ClientsController do
  use StorexWeb, :controller

  alias Storex.Client

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

  def sign_up(conn, params) do
    with {:ok, %Client{email: email, password: password} = client} <-
           Storex.create_client(params),
         {:ok, token, _client} <-
           AuthGuardian.authenticate(%{"email" => email, "password" => password}) do
      conn
      |> put_status(:created)
      |> render("sign_up.json", client: client, token: token)
    end
  end
end
