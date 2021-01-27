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
    do_cols_solved?(board, count(board) - 1)
  end

  defp do_cols_solved?(board, index) when index >= 0 do
    max = count(board)
    col = map(board, fn row -> at(row, index) end)
    sort(col) == to_list(1..max) and do_cols_solved?(board, index - 1)
  end

  defp do_cols_solved?(_, -1), do: true
end
