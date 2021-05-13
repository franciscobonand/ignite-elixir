defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "when all params are valid, returns an item" do
      response = Item.build("Peperoni", :pizza, 35.5, 1)

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when theres and invalid category, returns error" do
      response = Item.build("Peperoni", :invalid, "35.5", 1)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when theres an invalid price, returns error" do
      response = Item.build("Peperoni", :pizza, "invalid", 1)

      expected_response = {:error, "Invalid price"}

      assert response == expected_response
    end

    test "when theres an invalid quantity, returns error" do
      response = Item.build("Peperoni", :pizza, "35.5", 0)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
