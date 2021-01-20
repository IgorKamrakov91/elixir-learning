defmodule CowInterrogator do
  def get_name do
    IO.gets("What is your name? ")
    |> String.trim
  end

  def get_cow_lover do
    IO.getn("Do you like cows? [y|n] ", 1)
  end

  def interrogate do
    name = get_name()
    case String.downcase(get_cow_lover()) do
       "y" ->
         IO.puts "Great! Here's a cow for you #{name}:"
         IO.puts cow_art()
       "n" ->
         IO.puts "That's a shame, #{name}."
       _ ->
         IO.puts "You should have entered 'y' or 'n'."
    end
  end

  def cow_art do
    path = Path.expand("support/cow.txt", __DIR__)
    case File.read(path) do
      {:ok, art} -> art
      {:error, _ } -> IO.puts "Error: cow.txt file not found"; System.halt(1)
    end
  end
end

CowInterrogator.interrogate()

# Todo: uncomment tests if need
#ExUnit.start
#defmodule InputOutputTest do
#  use ExUnit.Case
#  import String
#
#  test "chec" do
#
#  end
#
#  test "checks if cow_art returns string from support/cow.txt" do
#    # this call checks if cow_art function returns art from txt file
#    art = CowInterrogator.cow_art
#    assert trim(art) |> first == "(" # first is implemented in String module
#  end
#end

