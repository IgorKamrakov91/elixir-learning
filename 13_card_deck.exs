defmodule Deck do
  # Create, shuffle, deal a set of 52 cards.

  # Returns a list of tuples, in sorted order.
  def new do
    for suit <- ~w(Hearts Clumbs Diamonds Spades),
        face <- [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"],
        do: {suit, face}
  end
end
