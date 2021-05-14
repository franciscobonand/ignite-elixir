defmodule ExliveryTest.Users.UserTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all params are valid, returns user" do
      response =
        User.build(
          "chico",
          "rua das bananeiras",
          "ch@ban.com",
          "12345",
          34
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response =
        User.build(
          "chico jr.",
          "rua das bananeiras",
          "ch@ban.com",
          "12345",
          3
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response

      assert response == expected_response
    end
  end
end
