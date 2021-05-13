defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "when all params are valid, returns an order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "temaki",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("21.90")
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert expected_response == response
    end

    test "when there are no items, returns error" do
      user = build(:user)

      response = Order.build(user, [])

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
