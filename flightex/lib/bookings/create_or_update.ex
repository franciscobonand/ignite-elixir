defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(uid, %{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination
      }) do
    get_date(complete_date)
    |> Booking.build(local_origin, local_destination, uid)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)
  end

  defp save_booking({:error, _msg} = error), do: error

  defp get_date([year, month, day, hour, min, sec]) do
    NaiveDateTime.new!(year, month, day, hour, min, sec)
  end
end
