defmodule Storex.Client do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:id, :name, :password, :password_hash, :email]

  @required_params [:name, :password, :email]

  @derive {Jason.Encoder, only: [:id, :name, :email]}

  schema "clients" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> put_password_hash()
    |> unique_constraint([:email])
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(%Changeset{valid?: false} = changeset), do: changeset
end
