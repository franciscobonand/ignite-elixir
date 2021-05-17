defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.User

  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(%User{id: uid}, complete_date, local_origin, local_destination) do
    %__MODULE__{
      id: UUID.uuid4(),
      complete_date: complete_date,
      local_origin: local_origin,
      local_destination: local_destination,
      user_id: uid
    }
  end

  def build(_uid, _cd, _lo, _ld), do: {:error, "Invalid parameters"}
end
