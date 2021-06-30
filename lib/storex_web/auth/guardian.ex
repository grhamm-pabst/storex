defmodule StorexWeb.Auth.Guardian do
  use Guardian, otp_app: :storex

  alias Storex.Client
  alias Storex.Clients.Get, as: ClientsGet

  alias Storex.Error

  def subject_for_token(%Client{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ClientsGet.by_id()
  end

  def authenticate(%{"email" => email, "password" => password}) do
    with {:ok, %Client{password_hash: hash} = client} <- ClientsGet.by_email(email),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(client) do
      {:ok, token, client}
    else
      _error -> {:error, Error.build(:unauthorized, "Please check your credentials")}
    end
  end

  def authenticate(_params), do: {:error, Error.build(:bad_request, "Invalid params")}
end
