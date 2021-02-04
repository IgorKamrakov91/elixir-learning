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
end
