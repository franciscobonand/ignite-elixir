defmodule SumList do
  @spec call([number]) :: number
  def call(list), do: sum(list, 0)

  @spec call_enum([number]) :: boolean
  def call_enum(list), do: Enum.any?(list, fn elem -> elem > 5 end)

  @spec sum([number], number) :: number
  defp sum([], acc), do: acc

  defp sum([head | tail], acc) do
    acc = acc + head
    sum(tail, acc)
  end
end
