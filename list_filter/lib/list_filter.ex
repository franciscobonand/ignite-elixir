defmodule ListFilter do
  @spec call(list(number())) :: non_neg_integer()
  def call(list) do
    intList = retrieveIntegers(list)
    oddList = retrieveOdds(intList)
    length(oddList)
  end

  @spec retrieveOdds(list(number())) :: list(number())
  defp retrieveOdds(list) do
    Enum.flat_map(list, fn num ->
      case Kernel.rem(num, 2) do
        0 -> []
        _ -> [num]
      end
    end)
  end

  @spec retrieveIntegers([String.t()]) :: list(number())
  defp retrieveIntegers(list) do
    Enum.flat_map(list, fn string ->
      case Integer.parse(string) do
        # if it's only an int, return it
        # otherwise skip it (in cases like '12ab')
        {int, rest} ->
          if rest == "",
            do: [int],
            else: []

        # skips value when it's not an int
        :error ->
          []
      end
    end)
  end
end
