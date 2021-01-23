ExUnit.start()

defmodule User do
  defstruct email: nil, password: nil
end

defimpl String.Chars, for: User do
  def to_string(%User{email: email}) do
    email
  end
end

defmodule RecordTest do
  use ExUnit.Case

  defmodule ScopeTest do
    use ExUnit.Case

    require Record
    Record.defrecordp :person, first_name: nil, last_name: nil, age: nil

    test "defrecordp" do
      person = person(first_name: "Kai", last_name: "Morgan", age: 5) # regular function call
      assert person == {:person, "Kai", "Morgan", 5} # just a tuple!
    end
  end

  def sample do
    %User{email: "kai@example.com", password: "trains"} # special % syntax for struct creation
  end

  test "defstruct" do
    assert sample() == %{__struct__: User, email: "kai@example.com", password: "trains"}
  end

  test "email" do
    assert sample().email == "kai@example.com"
  end

  test "protocol" do
    assert to_string(sample()) == "kai@example.com"
  end
end
