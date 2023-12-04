defmodule ListFilterTest do
  use ExUnit.Case

  describe "get_odds/1" do
    test "empty list" do
      list = []
      expected = []
      resp = ListFilter.get_odds(list)
      assert resp == expected
    end

    test "list without odd numbers" do
      list = ["2", "4", "114", "asdf"]
      expected = []
      resp = ListFilter.get_odds(list)
      assert resp == expected
    end

    test "list with odd numbers" do
      list = ["2", "4", "133", "asdf", "9"]
      expected = [133, 9]
      resp = ListFilter.get_odds(list)
      assert resp == expected
    end
  end
end
