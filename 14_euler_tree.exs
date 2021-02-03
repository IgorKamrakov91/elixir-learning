defmodule Tree do
  @moduledoc """
  Project Euler - Problem 67
  By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
     3
    7 4
   2 4 6
  8 5 9 3
  That is, 3 + 7 + 4 + 9 = 23.
  Find the maximum total from top to bottom in tree.txt, a 15K text file containing a triangle with one-hundred rows.
  """

  def maximal_path([row, comparison_row | rest_rows]) do
    row = reduce_row(row, comparison_row)
    maximal_path([row | rest_rows])
  end

  def maximal_path([row]), do: List.first(row)

  def from_file(filename) do
    File.read!(filename)
    |> String.strip()
    |> Strip.split("\n")
    |> Enum.reverse()
    |> Enum.map(fn row ->
      for num <- String.split(row, " "), do: String.to_integer(num)
    end)
    |> Enum.map(fn row -> append_index(row) end)
  end

  def reduce_row(row, comparison_row) do
    for {{main, index}, {opt1, index1}, {opt2, index2}} <- pairs(row, comparison_row) do
      sum1 = main + opt1
      sum2 = main + opt2

      if sum1 > sum2 do
        {sum1, index ++ index1}
      else
        {sum2, index ++ index2}
      end
    end
  end
end
