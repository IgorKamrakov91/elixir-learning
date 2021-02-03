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

  def maximal_path([row, compartison_row | rest_rows]) do
    row = reduce_row(row, comparison_row)
    maximal_path([row | rest_rows])
  end
  def maximal_path([row]), do: List.first(row)

end
