defmodule Exlivery do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Users.CreateOrUpdate, as: CoRUsers
  alias Exlivery.Orders.CreateOrUpdate, as: CoROrders

  def start_agents do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params),
    to: CoRUsers,
    as: :call

  defdelegate create_or_update_order(params),
    to: CoROrders,
    as: :call
end
