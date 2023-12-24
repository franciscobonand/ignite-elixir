defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @kinds ~w(users foods)

  def build(fname) do
    fname
    |> Parser.parse_file()
    |> Enum.reduce(%{"users" => %{}, "foods" => %{}}, fn line, report ->
      sum_values(line, report)
    end)
  end

  def fetch_higher_cost(report, kind) when kind in @kinds do
    {:ok, Enum.max_by(report[kind], fn {_, val} -> val end)}
  end

  def fetch_higher_cost(_, _), do: {:error, "Invalid kind"}

  defp sum_values([id, food_name, price], %{"users" => users, "foods" => foods} = report) do
    users = Map.put(users, id, add_nums(users[id], price))
    foods = Map.put(foods, food_name, add_nums(foods[food_name], 1))
    %{report | "users" => users, "foods" => foods}
  end

  defp add_nums(nil, n2), do: n2
  defp add_nums(n1, n2), do: n1 + n2

  def print_kinds(), do: IO.inspect(@kinds)
end
