defmodule StorexWeb.ClientsControllerTest do
  use StorexWeb.ConnCase, async: true

  import Storex.Factory

  describe "sign_in/2" do
    test "when the credentials are valid, authenticates the client", %{conn: conn} do
      insert(:client)
      params = %{"email" => "grhammpabst@email.com", "password" => "123456"}

      response =
        conn
        |> post(Routes.clients_path(conn, :sign_in, params))
        |> json_response(:ok)

      assert %{
               "client" => %{
                 "email" => "grhammpabst@email.com",
                 "id" => "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
                 "name" => "Grhamm Pabst"
               },
               "token" => _token
             } = response
    end

    test "when there are invalid credentials, returns an error", %{conn: conn} do
      params = %{"email" => "g@e.c", "password" => "1236"}

      response =
        conn
        |> post(Routes.clients_path(conn, :sign_in, params))
        |> json_response(:unauthorized)

      expected_response = %{"message" => "Please check your credentials"}

      assert expected_response == response
    end
  end

  describe "sign_up/2" do
    test "when the params are valid, returns a created and authenticated client", %{conn: conn} do
      params = build(:client_params)

      response =
        conn
        |> post(Routes.clients_path(conn, :sign_up, params))
        |> json_response(:created)

      assert %{
               "client" => %{
                 "email" => "grhammpabst@email.com",
                 "id" => _id,
                 "name" => "Grhamm Pabst"
               },
               "message" => "Client created!",
               "token" => _token
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{"name" => "G", "email" => "ggmail.com", "password" => "123"}

      response =
        conn
        |> post(Routes.clients_path(conn, :sign_up, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "email" => ["has invalid format"],
          "name" => ["should be at least 2 character(s)"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert expected_response == response
    end
  end
end
