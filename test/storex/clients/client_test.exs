defmodule Storex.ClientTest do
  use Storex.DataCase, async: true

  import Storex.Factory

  alias Ecto.Changeset

  alias Storex.Client

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:client_params)

      response = Client.changeset(params)

      assert %Changeset{
               valid?: true,
               changes: %{
                 email: "grhammpabst@email.com",
                 name: "Grhamm Pabst",
                 password: _password,
                 password_hash: _pass_hash
               }
             } = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        "name" => "G",
        "email" => "grhammpabstemail.com",
        "password" => "123"
      }

      response = Client.changeset(params)

      expected_response = %{
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"],
        password: ["should be at least 6 character(s)"]
      }

      assert expected_response == errors_on(response)
    end
  end
end
