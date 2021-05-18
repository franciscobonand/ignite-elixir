defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.CreateOrUpdate, as: CorUUsers
  alias Flightex.Bookings.CreateOrUpdate, as: CorUBookings

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params),
    to: CorUUsers,
    as: :call

  defdelegate create_or_update_booking(params),
    to: CorUBookings,
    as: :call
end
