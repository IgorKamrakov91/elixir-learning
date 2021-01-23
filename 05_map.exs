ExUnit.start()

defmodule MapTest do
  use ExUnit.Case, async: true

  def sample do
    %{foo: 'bar', baz: 'quz'}
  end

  test "Map.get" do
    assert Map.get(sample(), :foo) == 'bar'
    assert Map.get(sample(), :not_exists) == nil
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

  test "Map.fetch" do
    {:ok, val} = Map.fetch(sample(), :foo)
    assert val == 'bar'
    :error = Map.fetch(sample(), :not_exists)
  end

  test "Map.put" do
    assert Map.put(sample(), :foo, 'bob') == %{foo: 'bob', baz: 'quz'}
    assert Map.put(sample(), :far, 'bar') == %{foo: 'bar', baz: 'quz', far: 'bar'}
  end

  test "Map.values" do
    # Map does not preserve order of keys, thus we Enum.sort
    assert Enum.sort(Map.values(sample())) == ['bar', 'quz']
  end

  text
end
