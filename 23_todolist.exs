# Playing with abstractions

defmodule TodoList do
  def new(), do: MultiList.new()

  # example how to create entry
  # entry = %{date: ~D[2018-12-19], title: "Dentist"}
  # and add it with add_entry function
  def add_entry(todo_list, entry) do
    MultiList.add(todo_list, entry.date, entry.title)
  end

  def entries(todo_list, date) do
    MultiList.get(todo_list, date)
  end
end

defmodule MultiList do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end
