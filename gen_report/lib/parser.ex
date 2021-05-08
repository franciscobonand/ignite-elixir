defmodule GenReport.Parser do
  @month_relation %{
    "1" => "janeiro",
    "2" => "fevereiro",
    "3" => "março",
    "4" => "abril",
    "5" => "maio",
    "6" => "junho",
    "7" => "julho",
    "8" => "agosto",
    "9" => "setembro",
    "10" => "outubro",
    "11" => "novembro",
    "12" => "dezembro"
  }

  @spec parse_file(String.t()) :: Enumerable.t()
  def parse_file(filename) do
    path = "reports/#{filename}.csv"

    case File.stat(path) do
      {:ok, _} ->
        path
        |> File.stream!()
        |> Stream.map(fn line -> parse_line(line) end)

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(0, &String.downcase/1)
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(3, &get_month_name/1)
  end

  defp get_month_name(month) do
    @month_relation[month]
  end
end
