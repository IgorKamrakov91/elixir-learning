# The goal here is to learn (a tiny bit) about the Supervisor
# We simply fire up the server from exercise 16 and restart it on failure.

Code.load_file("./16_gen_server.exs")

defmodule PrimeFactorsServer.Sup do
	use Supervisor

	def start_link do
		:supervisor.start_link(__MODULE__, [])
	end
end