defmodule Storex.Clients.Get do
  alias Storex.{Client, Error, Repo}

  def by_id(id) do
    case Repo.get(Client, id) do
      nil -> {:error, Error.build(:not_found, "This Client doesn't exist")}
      %Client{} = client -> {:ok, client}
    end
  end

  def by_email(email) do
    case Repo.get_by(Client, email: email) do
      nil -> {:error, Error.build(:not_found, "This Client doesn't exist")}
      %Client{} = client -> {:ok, client}
    end
  end
end
