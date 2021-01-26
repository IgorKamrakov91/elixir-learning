defmodule Pinger do
  @doc "Send message (echo) to the next process in the ring."
  def ping(echo, limit) do
    receive do
      # got message, send another message to the next process in the ring
      {[next | rest], msg, count} when count <= limit ->
        IO.puts("Received: #{inspect(msg)} (count #{count})")
        :timer.sleep(1000)
        send(next, {rest ++ [next], echo, count + 1})
        ping(echo, limit)

      # over our limit of messages, send :ok to ring
      {[next | rest], _, _} ->
        send(next, {rest, :ok})

      # someone told us to stop, so pass along the message
      {[next | rest], :ok} ->
        send(next, {rest, :ok})
    end
  end
end

defmodule Spawner do
  def start do
    limit = 5
    {foo, _foo_monitor} = spawn_monitor(Pinger, :ping, ["ping", limit])
    {bar, _bar_monitor} = spawn_monitor(Pinger, :ping, ["pong", limit])
    {baz, _baz_monitor} = spawn_monitor(Pinger, :ping, ["pung", limit])
    send(foo, {[bar, baz, foo], "start", 0})
    wait([foo, bar, baz])
  end
end
