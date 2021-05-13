defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      cpf = "12345677"

      {:ok, cpf: cpf}
    end

    test "when the user is found, returns the user",
         %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok,
         %User{
           address: "rua das bananeiras",
           age: 34,
           cpf: "12345677",
           email: "ch@ban.com",
           name: "chico"
         }}

      assert response == expected_response
    end

    test "when the user isn't found, returns an error" do
      response = UserAgent.get("invalid")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
