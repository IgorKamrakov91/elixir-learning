defmodule Deck do
  # Create, shuffle, deal a set of 52 cards.

  # Returns a list of tuples, in sorted order.
  def new do
    for suit <- ~w(Hearts Clumbs Diamonds Spades),
        face <- [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"],
        do: {suit, face}
  end

  # Given a list of cards (a deck), reorder cards randomly.
  # If no deck is given, then create a new one and shuffle that.
  def shuffle(deck \\ new()) do
    Enum.shuffle(deck)
  end

  @doc """
    Given a deck of cards, a list of players, and a deal function,
    call the deal function for each card for each player. The function
    should return the updated player.
    Returns the list of players.
  """
  def _deal([], players, _, _), do: {players, []}
end
