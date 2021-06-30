defmodule Storex.Factory do
  use ExMachina.Ecto, repo: Storex.Repo

  alias Storex.Client

  def client_params_factory do
    %{
      "name" => "Grhamm Pabst",
      "email" => "grhammpabst@email.com",
      "password" => "123456"
    }
  end

  def client_factory do
    %Client{
      id: "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
      name: "Grhamm Pabst",
      email: "grhammpabst@email.com",
      password_hash:
        "$pbkdf2-sha512$160000$CEzr.kzfgk6IlUewm4RGbw$RZG4DmnAlfu7G2/bpwHIAfZzGQK/G9OjZBvttmlazDWPSBD9PRTMPoHR9PbhbCtjbZFaWwLwQ1sqrFap9Y9aCw",
      password: "123456"
    }
  end
end
