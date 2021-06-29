defmodule Storex.Clients.CreateTest do
  use Storex.DataCase, async: true

  import Storex.Factory

  alias Storex.{Client, Error}
  alias Storex.Clients.Create

  describe "call/1" do
    test "when all params are valid, returns the created client" do
      params = build(:client_params)

      response = Create.call(params)

      assert {:ok,
              %Client{
                email: "grhammpabst@email.com",
                id: _id,
                inserted_at: _in_date,
                name: "Grhamm Pabst",
                password: "123456",
                password_hash: _pass_hash,
                updated_at: _up_date
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:client_params, %{"name" => "G"})

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: _result}} = response
    end
  end
end
