defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.CreateOrUpdate, as: CorUUsers
  alias Flightex.Bookings.CreateOrUpdate, as: CorUBookings

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_user(params),
    to: CorUUsers,
    as: :call

  defdelegate get_user(id),
    to: UserAgent,
    as: :get

  defdelegate create_booking(uid, params),
    to: CorUBookings,
    as: :call

  defdelegate get_booking(booking_id),
    to: BookingAgent,
    as: :get
end
