ExUnit.start()

defmodule MapTest do
  use ExUnit.Case, async: true

  def sample do
    %{foo: 'bar', baz: 'quz'}
  end

  test "Map.get" do
    assert Map.get(sample(), :foo) == 'bar'
    assert Map.get(sample, :not_exists) == nil
  end

  test "[]" do
    assert sample()[:foo] == 'bar'
    assert sample()[:not_exists] == nil
  end

  test "." do
    assert sample().foo == 'bar'
    assert_raise KeyError, fn ->
      assert sample().not_exists
    end
  end
end
