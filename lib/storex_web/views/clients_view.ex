defmodule StorexWeb.ClientsView do
  use StorexWeb, :view

  alias Storex.Client

  def render("sign_in.json", %{token: token, client: %Client{} = client}) do
    %{
      token: token,
      client: client
    }
  end

  def render("sign_up.json", %{client: client, token: token}) do
    %{
      message: "Client created!",
      token: token,
      client: client
    }
  end
end
