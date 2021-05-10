defmodule GenReportTest do
  use ExUnit.Case

  @filename "test.csv"

  describe "build/1" do
    test "generates report given valid csv file" do
      respose = GenReport.build(@filename)

      expected_resp =
        {:ok,
         %{
           "all_hours" => %{
             "cleiton" => 8,
             "daniele" => 14,
             "danilo" => 8,
             "diego" => 5,
             "joseph" => 5,
             "mayk" => 3,
             "rafael" => 12
           },
           "hours_per_month" => %{
             "cleiton" => %{"junho" => 5, "novembro" => 3},
             "daniele" => %{"novembro" => 14},
             "danilo" => %{"novembro" => 8},
             "diego" => %{"novembro" => 5},
             "joseph" => %{"janeiro" => 5},
             "mayk" => %{"junho" => 3},
             "rafael" => %{"janeiro" => 5, "junho" => 7}
           },
           "hours_per_year" => %{
             "cleiton" => %{"2019" => 5, "2020" => 3},
             "daniele" => %{"2016" => 6, "2018" => 8},
             "danilo" => %{"2020" => 8},
             "diego" => %{"2018" => 5},
             "joseph" => %{"2017" => 5},
             "mayk" => %{"2016" => 3},
             "rafael" => %{"2018" => 7, "2020" => 5}
           }
         }}

      assert respose == expected_resp
    end

    test "invalid function argument" do
      respose = GenReport.build(123)

      expected_resp = {:error, :enoent}

      assert respose == expected_resp
    end
  end

  describe "build_from_many/1" do
    test "generates report given list of valid files" do
      respose = GenReport.build_from_many([@filename, @filename])

      expected_resp = %{
        "all_hours" => %{
          "cleiton" => 16,
          "daniele" => 28,
          "danilo" => 16,
          "diego" => 10,
          "joseph" => 10,
          "mayk" => 6,
          "rafael" => 24
        },
        "hours_per_month" => %{
          "cleiton" => %{"junho" => 10, "novembro" => 6},
          "daniele" => %{"novembro" => 28},
          "danilo" => %{"novembro" => 16},
          "diego" => %{"novembro" => 10},
          "joseph" => %{"janeiro" => 10},
          "mayk" => %{"junho" => 6},
          "rafael" => %{"janeiro" => 10, "junho" => 14}
        },
        "hours_per_year" => %{
          "cleiton" => %{"2019" => 10, "2020" => 6},
          "daniele" => %{"2016" => 12, "2018" => 16},
          "danilo" => %{"2020" => 16},
          "diego" => %{"2018" => 10},
          "joseph" => %{"2017" => 10},
          "mayk" => %{"2016" => 6},
          "rafael" => %{"2018" => 14, "2020" => 10}
        }
      }

      assert respose == expected_resp
    end

    test "generates report given one valid and one invalid file" do
      respose = GenReport.build_from_many([@filename, "invalid_file"])

      expected_resp = %{
        "all_hours" => %{
          "cleiton" => 8,
          "daniele" => 14,
          "danilo" => 8,
          "diego" => 5,
          "joseph" => 5,
          "mayk" => 3,
          "rafael" => 12
        },
        "hours_per_month" => %{
          "cleiton" => %{"junho" => 5, "novembro" => 3},
          "daniele" => %{"novembro" => 14},
          "danilo" => %{"novembro" => 8},
          "diego" => %{"novembro" => 5},
          "joseph" => %{"janeiro" => 5},
          "mayk" => %{"junho" => 3},
          "rafael" => %{"janeiro" => 5, "junho" => 7}
        },
        "hours_per_year" => %{
          "cleiton" => %{"2019" => 5, "2020" => 3},
          "daniele" => %{"2016" => 6, "2018" => 8},
          "danilo" => %{"2020" => 8},
          "diego" => %{"2018" => 5},
          "joseph" => %{"2017" => 5},
          "mayk" => %{"2016" => 3},
          "rafael" => %{"2018" => 7, "2020" => 5}
        }
      }

      assert respose == expected_resp
    end
  end
end
