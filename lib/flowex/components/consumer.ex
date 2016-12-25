defmodule Flowex.Consumer do
  use Experimental.GenStage

  def init(subscribe_to \\ []) do
    subscribe_to = Enum.map(subscribe_to, &({&1,  max_demand: 1}))
    {:consumer, nil, subscribe_to: subscribe_to}
  end

  def handle_events([ip], _from, nil) do
    send(ip.requester, ip)
    {:noreply, [], nil}
  end

  def handle_cast({in_pid, ip}, nil) do
    send(in_pid, ip)
    {:noreply, [], nil}
  end
end
