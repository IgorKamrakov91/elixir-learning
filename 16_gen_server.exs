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
		
	def prime?(2), do: true
	def prime?(number) do
		prime?(number, :math.sqrt(number) |> :erlang.trunc)
	end
	
	defp prime?(_, 1), do: true
	defp prime?(number, div) do
		if rem(number, div) == 0 do
			false
		else
			prime?(number, div - 1)
		end
	end
end

defmodule PrimeFactorsServer do
  @moduledoc """
  Wrap the PrimeFactors.prime_factors functionality in a server.
  """
	
	use GenServer
	import PrimeFactors
	
	def start_link do
		:gen_server.start_link({:local, :prime_factors}, __MODULE__, [], [])
	end
	
	def init(_args) do
		{:ok, []}
	end
	
	# synchronous
	def handle_call(:flush, _from, context) do
		{:reply, context, []}
	end
	
	def handle_call(num, _from, context) do
		{:reply, prime_factors(num), context}
	end
	
	# asynchronous
	def handle_cast(num, context) do
		{:noreply, [{num, prime_factors(num)} | context]}
	end
end