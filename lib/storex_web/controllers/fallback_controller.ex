defmodule StorexWeb.FallbackController do
  use StorexWeb, :controller

  alias Storex.Error
  alias StorexWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
