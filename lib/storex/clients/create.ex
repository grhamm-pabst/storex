defmodule Storex.Clients.Create do
  alias Storex.{Client, Error, Repo}

  def call(params) do
    params
    |> Client.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, _client} = result), do: result
  defp handle_insert({:error, reason}), do: {:error, Error.build(:bad_request, reason)}
end
