defmodule StorexWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :storex

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
