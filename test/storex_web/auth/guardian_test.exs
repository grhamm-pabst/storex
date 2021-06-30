defmodule StorexWeb.Auth.GuardianTest do
  use StorexWeb.ConnCase, async: true

  import Storex.Factory

  alias Storex.Client

  alias StorexWeb.Auth.Guardian

  describe "authenticate/1" do
    test "when is given valid credentials, returns the authenticated client and the token" do
      %Client{email: email} = insert(:client)

      params = %{"email" => email, "password" => "123456"}

      response = Guardian.authenticate(params)

      assert {:ok, _token, %Client{email: "grhammpabst@email.com"}} = response
    end

    test "when the credentials are invalid, returns an error" do
      %Client{email: email} = insert(:client)

      params = %{"email" => email, "password" => "1234567"}

      response = Guardian.authenticate(params)

      expected_response = {
        :error,
        %Storex.Error{result: "Please check your credentials", status: :unauthorized}
      }

      assert expected_response == response
    end

    test "when the client doesn't exist, returns an error" do
      %Client{email: email} = build(:client)

      params = %{"email" => email, "password" => "123456"}

      response = Guardian.authenticate(params)

      expected_response = {
        :error,
        %Storex.Error{result: "Please check your credentials", status: :unauthorized}
      }

      assert expected_response == response
    end
  end
end
