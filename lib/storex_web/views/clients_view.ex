defmodule StorexWeb.ClientsView do
  use StorexWeb, :view

  alias Storex.Client

  def render("sign_in.json", %{token: token, client: %Client{} = client}) do
    %{
      token: token,
      client: client
    }
  end
end
