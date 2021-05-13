defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "rua das bananeiras",
      age: 34,
      cpf: "12345",
      email: "ch@ban.com",
      name: "chico"
    }
  end

  def item_factory do
    %Item{
      description: "Peperoni",
      category: :pizza,
      unity_price: Decimal.new("35.5"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      delivery_address: "rua das bananeiras",
      items: [
        build(:item),
        build(:item,
          description: "temaki",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("21.90")
        )
      ],
      total_price: Decimal.new("79.30"),
      user_cpf: "12345"
    }
  end
end
