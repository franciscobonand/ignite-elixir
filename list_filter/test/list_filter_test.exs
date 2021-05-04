defmodule ListFilterTest do
  use ExUnit.Case

  describe "call" do
    test "empty list" do
      list = []
      expected_result = 0
      result = ListFilter.call(list)

      assert result == expected_result
    end

    test "list without numbers" do
      list = ["asbc", "asdf", "jsf", "ododo"]
      expected_result = 0
      result = ListFilter.call(list)

      assert result == expected_result
    end

    test "list without odd numbers" do
      list = ["1234", "asd12f", "12", "0"]
      expected_result = 0
      result = ListFilter.call(list)

      assert result == expected_result
    end

    test "list with odd numbers" do
      list = ["123", "asd12f", "12", "7"]
      expected_result = 2
      result = ListFilter.call(list)

      assert result == expected_result
    end
  end
end
