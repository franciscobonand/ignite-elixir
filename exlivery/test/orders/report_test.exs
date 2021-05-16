defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    setup %{} do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      on_exit(fn -> File.rm!("report_test.csv") end)
    end

    test "cretes the report file" do
      expected_response =
        "12345,pizza,1,35.5,japonesa,2,21.90,79.30\n" <>
          "12345,pizza,1,35.5,japonesa,2,21.90,79.30\n"

      Report.create("report_test.csv")
      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
