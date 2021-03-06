defmodule Storex do
  @moduledoc """
  Storex keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Storex.Clients.Create, as: ClientsCreate

  defdelegate create_client(params), to: ClientsCreate, as: :call
end
