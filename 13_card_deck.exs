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
  def _deal(cards, players, _, 0), do: {players, cards}

  def _deal([card | rest_cards], [player | rest_players], deal_fn, cards_left) do
    player = deal_fn.(card, player)
    _deal(rest_cards, rest_players ++ [player], deal_fn, cards_left - 1)
  end

  def deal(cards, players, deal_fn, cards_per_player \\ 52) do
    cards_left = cards_per_player * Enum.count(players)
    _deal(cards, players, deal_fn, cards_left)
  end
end

ExUnit.start

defmodule DeckTest do
  use ExUnit.Case

  test "new" do
    deck = Deck.new
    assert Enum.at(deck, 0) == {"Hearts", 2}
    assert Enum.at(deck, 51) == {"Spades", "A"}
  end

  test "shuffle" do
    :random.seed(:erlang.now)
    deck = Deck.shuffle
    assert Deck.shuffle != deck
    assert length(Deck.shuffle) == 52
  end
end
