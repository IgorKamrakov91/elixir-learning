ExUnit.start()

defmodule ListTest do
  use ExUnit.case

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
end
