Code.load_file("./10-sudoku-board.exs")

defmodule SudokuSolver do
  import Enum

  def solve(board) do
    board
    |> solutions()
    |> map(fn s -> apply_solution(board, s) end)
    |> find(fn b -> SudokuBoard.solved?(b) end)
  end

  def apply_solution(board, [first | rest]) do
    size = count(board)
    board = List.flatten(board)
    pos = find_index(board, fn col -> col == nil end)

    List.replace_at(board, pos, first)
    |> chunk_every(size)
    |> apply_solution(rest)
  end

  def apply_solution(board, []), do: board

  @doc """
  Returns possible combinations for solving the board.
  ## Example
    iex> board = [[1,   nil, 3  ],
                  [3,   nil, 2  ],
                  [nil, 3,   nil]]
    iex> SudokuSolver.solutions(board)
    [[2, 1, 1, 2], [2, 1, 2, 1]]
  """

  def solutions(board) do
    possibles(board) |> combinations()
  end

  defp possibles([row | rest]) do
    possible = to_list(1..count(row)) -- row
    [possible | possibles(rest)]
  end

  defp possibles([]), do: []

  @doc """
  Given a list of possibilities for each row, return all possible combinations.
  ## Example
    iex> SudokuSolver.combinations([[1], [2], [3, 4]])
    [[1, 2, 3, 4], [1, 2, 4, 3]]
  """
  def combinations([list | rest]) do
    crest = combinations(rest)

    for p <- permutations(list), r <- crest do
      List.flatten([p | r])
    end
  end

  def combinations([]), do: [[]]

  @doc """
  Return all possible permuations of a list.
  ## Example
    iex> SudokuSolver.permutations([1,2,3])
    [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
  """
  def permutations([]), do: [[]]

  def permutations(list) do
    for h <- list, t <- permutations(list -- [h]), do: [h | t]
  end
end

ExUnit.start()

defmodule SudokuSolverTest do
  use ExUnit.Case
  import SudokuSolver

  test "correct behavior of combinations" do
    assert combinations([[1]]) == [[1]]
    assert combinations([[2, 3], [1]]) == [[2, 3, 1], [3, 2, 1]]
    assert combinations([[1], [2], [3, 4]]) == [[1, 2, 3, 4], [1, 2, 4, 3]]
  end

  test "solves small board" do
  end

  test "return nil on unsolvable board" do
  end
end
