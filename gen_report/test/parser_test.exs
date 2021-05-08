defmodule GenReport.ParserTest do
  use ExUnit.Case

  alias GenReport.Parser

  describe "parse_file/1" do
    test "parses valid file" do
      filename = "test"

      response =
        filename
        |> Parser.parse_file()
        |> Enum.map(& &1)

      expected_response = [
        ["daniele", 8, "30", "novembro", "2018"],
        ["danilo", 8, "6", "novembro", "2020"],
        ["mayk", 3, "18", "junho", "2016"],
        ["daniele", 6, "12", "novembro", "2016"],
        ["rafael", 7, "29", "junho", "2018"],
        ["joseph", 5, "1", "janeiro", "2017"],
        ["cleiton", 3, "2", "novembro", "2020"],
        ["diego", 5, "27", "novembro", "2018"],
        ["cleiton", 5, "9", "junho", "2019"],
        ["rafael", 5, "25", "janeiro", "2020"]
      ]

      assert response == expected_response
    end

    test "try to parse invalid file" do
      filename = "nonexistent_file"

      response = Parser.parse_file(filename)

      expected_response = {:error, :enoent}

      assert response == expected_response
    end
  end
end
