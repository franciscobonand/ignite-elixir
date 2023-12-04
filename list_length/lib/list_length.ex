defmodule ListLength do
  def call(list), do: length(list, 0)

  defp length([], acc), do: acc

  defp length([_ | t], acc) do
    length(t, acc + 1)
  end
end
