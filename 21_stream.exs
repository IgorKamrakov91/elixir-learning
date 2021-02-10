defmodule Fib do
  @moduledoc """
    Lazy Fibonacci Sequence
  """

  defmodule FibVal do
    defstruct val: 0, next: 1
  end

  # Return a lazy sequence of FibVals.
  def fib do
    Stream.iterate(%FibVal{}, fn %FibVal{val: val, next: next} ->
      %FibVal{val: next, next: val + next}
    end)
  end

  def fib2 do
    Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
  end
end
