defmodule Fib do
  @seed [0,1]

  def fib(n) when n < 2 do
    Enum.take(@seed, n)
  end

  def fib(n) when n >= 2 do
    fib(@seed, n - 2)
  end

  def fib(acc, 0), do: acc

  def fib(acc, n) do
    fib(acc ++ [Enum.at(acc, -2) + Enum.at(acc, -1)], n - 1)
  end
end
