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

  def build_from_many(fnames) when not is_list(fnames) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(fnames) do
    res =
      fnames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(%{"users" => %{}, "foods" => %{}}, fn {:ok, result}, report ->
        sum_reports(report, result)
      end)

    {:ok, res}
  end

  def fetch_higher_cost(report, kind) when kind in @kinds do
    {:ok, Enum.max_by(report[kind], fn {_, val} -> val end)}
  end

  def fetch_higher_cost(_, _), do: {:error, "Invalid kind"}

  defp sum_values([id, food_name, price], %{"users" => users, "foods" => foods}) do
    users = Map.put(users, id, add_nums(users[id], price))
    foods = Map.put(foods, food_name, add_nums(foods[food_name], 1))
    build_report(users, foods)
  end

  defp add_nums(nil, n2), do: n2
  defp add_nums(n1, n2), do: n1 + n2

  defp sum_reports(%{"users" => users1, "foods" => foods1}, %{
         "users" => users2,
         "foods" => foods2
       }) do
    foods = merge_maps(foods1, foods2)
    users = merge_maps(users1, users2)
    build_report(users, foods)
  end

  defp merge_maps(m1, m2) do
    Map.merge(m1, m2, fn _k, v1, v2 -> v1 + v2 end)
  end

  defp build_report(users, foods), do: %{"users" => users, "foods" => foods}
end
