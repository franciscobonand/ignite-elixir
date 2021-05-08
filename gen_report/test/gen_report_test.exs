defmodule GenReportTest do
  use ExUnit.Case

  describe "build/1" do
    test "generates report given valid csv file" do
      respose = GenReport.build("test")

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

    test "invalid function argument" do
      respose = GenReport.build(123)

      expected_resp = {:error, :enoent}

      assert respose == expected_resp
    end
  end
end
