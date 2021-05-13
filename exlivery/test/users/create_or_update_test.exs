defmodule Exlivey.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves user" do
      params = %{
        name: "chico",
        address: "rua X",
        email: "xpirito@email.com",
        cpf: "121212",
        age: 31
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns error" do
      params = %{
        name: "chico",
        address: "rua X",
        email: "xpirito@email.com",
        cpf: "121212",
        age: 12
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
