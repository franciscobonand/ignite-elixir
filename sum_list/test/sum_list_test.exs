defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "resturns list sum" do
      list = [1, 2, 3]
      expect = 6
      resp = SumList.call(list)
      assert resp == expect
    end

    test "resturns empty list sum" do
      list = []
      expect = 0
      resp = SumList.call(list)
      assert resp == expect
    end
  end
end
