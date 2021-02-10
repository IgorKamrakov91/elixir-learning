ExUnit.start()

defmodule SetTest do
  use ExUnit.Case

  test "to_list" do
    list = Enum.into([1, 2, 2, 3], MapSet.new()) |> MapSet.to_list()
    assert list == [2, 3, 1]
  end
end
