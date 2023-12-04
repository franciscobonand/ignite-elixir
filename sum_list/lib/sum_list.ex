defmodule SumList do
  def call(list), do: sum(list, 0)

  def has_even(list), do: Enum.any?(list, fn x -> rem(x, 2) == 0 end)

  defp sum([], acc), do: acc

  defp sum([head | tail], acc) do
    # IO.inspect(tail)
    sum(tail, acc + head)
  end
end
