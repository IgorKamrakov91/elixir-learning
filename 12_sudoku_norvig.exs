defmodule SudokuSolver do
  @moduledoc """
  Solves 9x9 Sudoku puzzles, Peter Norvig style.
  http://norvig.com/sudoku.html
  """

  @size 9
  @rows 'ABCDEFGHI'
  @cols '123456789'

  import Enum

  defmodule Board do
    defstruct squares: nil, units: nil, peers: nil
  end

  def cross(list_a, list_b) do
    for a <- list_a, b <- list_b do
      [a] ++ [b]
    end
  end

  @doc "Return all squares"
  def squares, do: cross(@rows, @cols)


  def unit_list do
    (for c <- @cols, do: cross(@rows, [c])) ++
    (for r <- @rows, do: cross([r], @cols)) ++
    (for rs <- chunk_every(@rows, 3), cs <- chunk_every(@cols, 3), do: cross(rs,cs))
  end

  @doc """
  All squares from unit_list, organized in a Map with each square as key.
     iex> Map.get(SudokuSolver.units, 'C2')
     [['A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'],
      ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'],
      ['A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3']]
  """

  def units do
    unit_list = unit_list()
    list = for square <- squares(), do { square, (for unit <- unit_list, square in unit, do: unit) }
    Enum.into(list, %{})
  end

  @doc """
  Like units/0 above, returning a Map, but not including the key itself.
  """

  def peers do
    squares = cross(@rows, @cols)
  end
end

ExUnit.start()

defmodule SudokuSolverTest do
  use ExUnit.Case
  import SudokuSolver

  def print(grid, solved) do
    IO.puts("puzzle----------")
    display(grid)
    IO.puts("solved----------")
    display(solved)
    IO.puts "\n"
  end

  test "solve easy" do
    grid1 = '..3.2.6..9..3.5..1..18.64....81.29..7.......8..67.82....26.95..8..2.3..9..5.1.3..'
    solved = solve(grid1)
    assert solved == '483921657967345821251876493548132976729564138136798245372689514814253769695417382'
    print(grid1, solved)
  end

  test "solve hard" do
    grid2 = '4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'
    solved = solve(grid2)
    assert solved == '417369825632158947958724316825437169791586432346912758289643571573291684164875293'
    print(grid2, solved)
  end
end
