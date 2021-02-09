defmodule WebServer do
  @moduledoc """
  $ iex 22-socket-server.exs
  	Then visit http://localhost:3000. You should see something like:
  	Your User-Agent is: Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0
  """

  def server do
	{:ok, lsock} = :gen_tcp.listen(3000, [:binary, {:packet, 0}, {:active, false}])
	accept_connection(lsock)
  end
end
