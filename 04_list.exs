
ExUnit.start

defmodule ListTest do
  use ExUnit.Case, async: true

  def sample() do
    ["Tim", "Jen", "Mac", "Kai"]
  end

  test "sigil" do
    assert sample() == ~w(Tim Jen Mac Kai)
  end

  test "head" do
    [head | _] = sample()
    assert head == "Tim"
  end

  test "tail" do
    [_ | tail] = sample()
    assert tail == ~w(Jen Mac Kai)
  end

  test "last item" do
    assert List.last(sample()) == "Kai"
  end

  test "delete item" do
    assert List.delete(sample(), "Mac") == ~w(Tim Jen Kai)
    # remove first occurence
    assert List.delete([1,2,2,3,4], 2) == [1,2,3,4]
  end

  test "List fordr" do
    list = [20, 10, 5, 2.5]
    sum = Enum.reduce list, 0, fn (num, sum) -> num + sum end
    assert sum == 37.5
  end
end
