ExUnit.start()

defmodule SetTest do
  use ExUnit.Case

  test "to_list" do
    list = Enum.into([1, 2, 2, 3], MapSet.new()) |> MapSet.to_list()
    assert list == [2, 3, 1]
  end

  test "union" do
    union = Enum.into([1, 2, 3], MapSet.new()) |> MapSet.union(Enum.into([2, 3, 4], MapSet.new()))
    assert MapSet.to_list(union) == [2, 3, 4, 1]
  end
end
