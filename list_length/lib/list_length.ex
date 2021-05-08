defmodule ListLength do
  @spec call([number()]) :: non_neg_integer()
  def call(list), do: length(list, 0)

  @spec length([number()], number()) :: number()
  defp length([], acc), do: acc

  defp length([_ | tail], acc) do
    acc = acc + 1
    length(tail, acc)
  end
end
