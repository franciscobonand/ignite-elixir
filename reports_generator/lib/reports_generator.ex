defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(fname) do
    fname
    |> Parser.parse_file()
    |> Enum.reduce(%{}, fn line, report -> sum_values(line, report) end)
  end

  def fetch_higher_cost(report), do: Enum.max_by(report, fn {_, val} -> val end)

  defp sum_values([id, _, price], report) do
    Map.put(report, id, add_nums(report[id], price))
  end

  defp add_nums(nil, n2), do: n2
  defp add_nums(n1, n2), do: n1 + n2
end
