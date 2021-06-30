defmodule Storex.Clients.GetTest do
  use Storex.DataCase, async: true

  import Storex.Factory

  alias Storex.Client
  alias Storex.Clients.Get

  describe "by_id/1" do
    test "when the client exists, returns the client" do
      %Client{id: id} = insert(:client)

      response = Get.by_id(id)

      assert {:ok,
              %Storex.Client{
                email: "grhammpabst@email.com",
                id: "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
                inserted_at: _in_date,
                name: "Grhamm Pabst",
                updated_at: _up_date
              }} = response
    end

    test "when the client with the given id doesn't exists, returns an error" do
      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43da"

      response = Get.by_id(id)

      expected_response =
        {:error, %Storex.Error{result: "This Client doesn't exist", status: :not_found}}

      assert expected_response == response
    end
  end

  describe "by_email/1" do
    test "when the client exists, returns the client" do
      %Client{email: email} = insert(:client)

      response = Get.by_email(email)

      assert {:ok,
              %Storex.Client{
                email: "grhammpabst@email.com",
                id: "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
                inserted_at: _in_date,
                name: "Grhamm Pabst",
                updated_at: _up_date
              }} = response
    end

    test "when the client with the given email doesn't exists, returns an error" do
      email = "grh@c.om"

      response = Get.by_email(email)

      expected_response =
        {:error, %Storex.Error{result: "This Client doesn't exist", status: :not_found}}

      assert expected_response == response
    end
  end
end
