defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_init_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user))
  end

  def get(uid), do: Agent.get(__MODULE__, &get_user(&1, uid))

  defp get_user(state, uid) do
    case Map.get(state, uid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{id: uid} = user) do
    IO.inspect(user)
    Map.put(state, uid, user)
  end
end
