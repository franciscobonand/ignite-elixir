defmodule GenReport.Parser do
  @months %{
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

  def parse_file(fname) do
    case File.exists?(fname) do
      true ->
        stream =
          fname
          |> File.stream!()
          |> Stream.map(fn line -> parse_line(line) end)

        {:ok, stream}

      false ->
        {:error, "Arquivo não encontrado"}
    end
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> format_data()
  end

  defp format_data([name, h, d, m, y]) do
    [
      String.downcase(name),
      String.to_integer(h),
      String.to_integer(d),
      @months[m],
      String.to_integer(y)
    ]
  end
end
