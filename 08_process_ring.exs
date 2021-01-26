defmodule Pinger do
  @doc "Send message (echo) to the next process in the ring."
  def ping(echo, limit) do
    receive do

      # someone told us to stop, so pass along the message
      {[next | rest], :ok} ->
        send(next, {rest, :ok})
    end
  end
end

defmodule Spawner do
end
