defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.Agent, as: UserAgent

  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, uid) do
    case UserAgent.get(uid) do
      {:error, _msg} = error ->
        error

      {:ok, _user} ->
        {:ok,
         %__MODULE__{
           id: UUID.uuid4(),
           complete_date: complete_date,
           local_origin: local_origin,
           local_destination: local_destination,
           user_id: uid
         }}
    end
  end
end
