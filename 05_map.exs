ExUnit.start()

defmodule MapTest do
  use ExUnit.Case, async: true

  def sample do
    %{foo: 'bar', baz: 'quz'}
  end

  def "Map.get" do
    assert Map.get(sample(), :foo) == 'bar'
    assert Map.get(sample, :not_exists) == nil
  end
end
