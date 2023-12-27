defmodule GenReport do
  alias GenReport.Parser

  def build(fname) do
    case Parser.parse_file(fname) do
      {:ok, stream} ->
        stream
        |> Enum.reduce(
          %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}},
          fn line, report ->
            sum_values(line, report)
          end
        )

      {:error, msg} ->
        {:error, msg}
    end
  end

  def build() do
    {:error, "Insira o nome de um arquivo"}
  end

  defp sum_values([name, h, _, m, y], %{
         "all_hours" => all,
         "hours_per_month" => hpm,
         "hours_per_year" => hpy
       }) do
    all = update_map(all, name, h)
    hpm = Map.update(hpm, name, %{m => h}, fn curr_name -> update_map(curr_name, m, h) end)
    hpy = Map.update(hpy, name, %{y => h}, fn curr_name -> update_map(curr_name, y, h) end)
    %{"all_hours" => all, "hours_per_month" => hpm, "hours_per_year" => hpy}
  end

  defp update_map(map, key, value) do
    Map.update(map, key, value, fn curr_value -> curr_value + value end)
  end
end
