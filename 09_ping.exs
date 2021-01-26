defmodule Ping do
  @moduledoc """
  Ping a class-C subnet to find hosts that respond.
  To run from the command line:
    $ elixir 09-ping.exs 192.168.1.x
  """

  @doc """
  Ping an IP asynchronously and send a tuple back to the parent saying what
  has happened:
  `{:ok, ip, pingable?}` where `pingable?` tells us if `ip` is pingable.
  `{:error, ip, error}` when some error caused us to not be able to run the
  ping command.
  """

  def ping_async(ip, parent) do
    send(parend, run_ping(ip))
  end

  def run_ping(ip) do
    
  end
end
