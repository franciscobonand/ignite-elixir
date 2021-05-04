defmodule ListLengthTest do
  use ExUnit.Case

  describe "call" do
    test "returns empty list length" do
      expected_result = 0
      result = ListLength.call([])

      assert result == expected_result
    end

    test "returns non-empty list length" do
      list = [3, 234, 5, 3, 45, 5]
      expected_result = Kernel.length(list)
      result = ListLength.call(list)

      assert result == expected_result
    end

    test "function call with invalid parameters" do
      invalid_param = "randomstring"

      try do
        ListLength.call(invalid_param)
        flunk("This point shouldnt be reached")
      catch
        _, _ -> :ok
      end
    end
  end
end
