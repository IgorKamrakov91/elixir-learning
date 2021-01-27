defmodule Sudoku do
  import Enum

  def solved?(board) do
    rows_solved?(board) and cols_solved?(board)
  end

  def rows_solved?([]), do: true
  def rows_solved?([row | rest]) do
    max = count(row)
    sort(row) == to_list(1..max) and rows_solved?(rest)
  end

  def cols_solved?(board) do
  end
end
