defmodule SudokuSolver do
  @doc """
  Given a list of possibilities for each row, return all possible combinations.
  """
  def combinations([]), do: [[]]
  def combinations([list | rest]) do
    crest = combinations(rest)
    for perm <- permutations(list), res <- crest do
      List.flatten([perm | res])
    end
  end

  @doc """
  Return all possible permuations of a list.
  ## Example
    iex> SudokuSolver.permutations([1,2,3])
    [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
  """
  def permutations([]), do: []
  def permutations(list) do
    for head <- list, tail <- permutations(list -- [head]), do: [head | tail]
  end
end

ExUnit.start()

defmodule SudokuSolverTest do
  use ExUnit.Case
  import SudokuSolver

  test "correct behavior of combinations" do
    assert combinations([[2, 3], [1]]) == [[2, 3, 1], [3, 2, 1]]
    assert combinations([[1], [2], [3, 4]]) == [[1, 2, 3, 4], [1, 2, 4, 3]]
  end

  test "solves small board" do
  end

  test "return nil on unsolvable board" do
  end
end
