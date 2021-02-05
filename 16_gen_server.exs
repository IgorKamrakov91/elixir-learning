defmodule	PrimeFactors do
  @moduledoc """
  Calculate prime factors of any number given.
  """

  @doc """
  Given a number, return a list of prime factors.
  """
	
	def prime_factors(number, div \\ 2, factors \\ []) do
		cond do
			prime?(number) ->
				[number | factors]
			rem(number, div) == 0 ->
				prime_factors(div(number, div), 2, [div | factors])
			true ->
				prime_factors(number, div + 1, factors)	
		end
	end
end