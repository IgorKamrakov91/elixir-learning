
ExUnit.start()

defmodule MyTest do
  use ExUnit.Case, async: true

  test "simple test" do
    assert 1 + 1 == 2
  end

  test "wrong failure test" do
    assert 1 + 1 != 3
  end

  test "assert raise" do
    assert_raise ArithmeticError, fn ->
      1 + "x"
    end
  end

  test "assert_in_delta asserts that val1 and val2 differ by less than delta." do
    assert_in_delta 1, 5, 6
  end
end
