defmodule ListFilter do
  def get_odds([]), do: []

  def get_odds(list) do
    Enum.map(
      list,
      fn x ->
        case Integer.parse(x) do
          {n, _} -> n
          :error -> :error
        end
      end
    )
    |> Enum.filter(fn x -> x != :error and rem(x, 2) == 1 end)
  end
end
