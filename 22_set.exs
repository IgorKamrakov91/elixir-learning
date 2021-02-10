ExUnit.start()

defmodule SetTest do
  use ExUnit.Case

  test "to_list" do
    list = Enum.into([1, 2, 2, 3], HashSet.new()) |> HashSet.to_list()
    # unintuitive ordering
    assert list == [2, 3, 1]
  end

  test "union" do
    union =
      Enum.into([1, 2, 3], HashSet.new()) |> HashSet.union(Enum.into([2, 3, 4], HashSet.new()))

    # unintuitive, but somewhat more understandable
    assert Set.to_list(union) == [2, 3, 4, 1]
  end
end