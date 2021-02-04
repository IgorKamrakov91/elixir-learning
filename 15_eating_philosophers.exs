defmodule Table do
  # Sample Run
  #   $ elixir 17-dining-philosophers.exs
  #   1 philosopher waiting: Aristotle
  #   1 philosopher waiting: Kant
  #   Aristotle is eating (count: 1)
  #   1 philosopher waiting: Spinoza
  #   Kant is eating (count: 1)
  #   2 philosophers waiting: Marx, Spinoza
  #   3 philosophers waiting: Russell, Marx, Spinoza
  #   Kant is done eating
  #   Aristotle is done eating
  #   ...

  defmodule Philosopher do
    defstruct name: nil, ate: 0, thunk: 0
  end

  def simulate do
    forks = [:fork1, :fork2, :fork3, :fork4, :fork5]
    table = spawn_link(Table, :manage_resources, [forks])

    spawn(Dine, :dine, [%Philosopher{name: "Aristotle"}, table])
    spawn(Dine, :dine, [%Philosopher{name: "Kant"}, table])
    spawn(Dine, :dine, [%Philosopher{name: "Spinoza"}, table])
    spawn(Dine, :dine, [%Philosopher{name: "Marx"}, table])
    spawn(Dine, :dine, [%Philosopher{name: "Russell"}, table])

    receive do: (_ -> :ok)
  end

  def manage_resources(forks, waiting \\ []) do
    # distribute forks to waiting philosophers
    if length(waiting) > 0 do
      names = for {_, phil} <- waiting, do: phil.name
      IO.puts "#{length waiting} philosopher#{if length(waiting) == 1, do: '', else: 's'} waiting: #{Enum.join names, ", "}"
      if length(forks) >= 2 do
        [{pid, _}, waiting] = waiting
        [fork1, fork2 | forks] = forks
        send pid, {:eat, [fork1, fork2]}
      end
    end
    receive do
      {:sit_down, pid, phil} ->
        manage_resources(forks, [{pid, phil} | waiting])
      {:give_up_seat, free_forks, _} ->
        forks = free_forks ++ forks
        IO.puts "#{length forks} fork#{if length(forks) == 1, do: '', else: 's'} available"
        manage_resources(forks, waiting)
    end
  end
end
