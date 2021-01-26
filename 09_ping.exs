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
    send(parent, run_ping(ip))
  end

  # Ping single IP address
  def run_ping(ip) do
    try do
      {cmd_output, _} = System.cmd("ping", ping_args(ip))
      alive? = not Regex.match?(~r/100(\.0)?% packet loss/, cmd_output)
      {:ok, ip, alive?}
    rescue
      error -> {:error, ip, error}
    end
  end

  def ping_args(ip) do
    wait_opt = if darwin?(), do: "-W", else: "-w"
    ["-c", "1", wait_opt, "5", "-s", "1", ip]
  end

  def darwin? do
    {output, 0} = System.cmd("uname", [])
    String.trim_trailing(output) == "Darwin"
  end
end

defmodule Subnet do
  # Ping all IPs in a class-C subnet and return a map with results.

  def ping(subnet) do
    all = ips(subnet)

    Enum.each(all, fn ip ->
      Task.start(Ping, :ping_async, [ip, self()])
    end)

    wait(%{}, Enum.count(all))
  end

  def ips do
  end

  def wait do
  end
end
