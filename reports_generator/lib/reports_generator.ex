# You can test the time taken to run each build method using the following:
# :timer.tc(fn -> ReportsGenerator.build_from_many(["report_1.csv", "report_2.csv", "report_3.csv"])
# and
# :timer.tc(fn -> ReportsGenerator.build("report_complete.csv")end)

defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]
  @options ["foods", "users"]
  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report ->
      sum_values(line, report)
    end)
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(
        report_acc(),
        fn {:ok, result}, report ->
          sum_reports(report, result)
        end
      )

    {:ok, result}
  end

  def fetch_higher_cost(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_key, value} -> value end)}
  end

  def fetch_higher_cost(_report, _option), do: {:error, "Invalid option"}

  defp sum_values([id, food, price], %{"foods" => foods, "users" => users}) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food, foods[food] + 1)

    build_report(foods, users)
    # The return could also be the following:
    # %{report | "users" => users, "foods" => foods}
    # This means "returt the Map report updating its
    # 'users' and 'foods' to the given values
  end

  defp sum_reports(
         %{"foods" => foods1, "users" => users1},
         %{"foods" => foods2, "users" => users2}
       ) do
    foods = merge_maps(foods1, foods2)
    users = merge_maps(users1, users2)
    build_report(foods, users)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, val1, val2 ->
      val1 + val2
    end)
  end

  def report_acc do
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
    foods = Enum.into(@available_foods, %{}, &{&1, 0})

    build_report(foods, users)
  end

  defp build_report(foods, users), do: %{"foods" => foods, "users" => users}
end
