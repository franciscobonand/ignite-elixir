defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds a report" do
      fname = "report_test.csv"
      response = ReportsGenerator.build(fname)

      expected = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pizza" => 2
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "2" => 45,
          "3" => 31,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected
    end
  end

  describe "fetch_higher_cost/2" do
    test "when kind is 'users', returns user that spent the most" do
      fname = "report_test.csv"

      response =
        fname
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("users")

      expected = {:ok, {"5", 49}}
      assert response == expected
    end

    test "when kind is 'foods', returns food that was most consumed" do
      fname = "report_test.csv"

      response =
        fname
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("foods")

      expected = {:ok, {"esfirra", 3}}
      assert response == expected
    end

    test "when invalid kind is received" do
      fname = "report_test.csv"

      response =
        fname
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("invalid")

      expected = {:error, "Invalid kind"}
      assert response == expected
    end
  end
end
