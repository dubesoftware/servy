defmodule Servy.PledgeServer do
  def listen_loop(state) do
    IO.puts("\nWaiting for a message...")

    receive do
      {:create_pledge, name, amount} ->
        {:ok, id} = send_pledge_to_service(name, amount)
				most_recent_pledges = Enum.take(state, 2)
        new_state = [{name, amount} | most_recent_pledges]
        IO.puts("#{name} pledged #{amount}!")
        IO.puts("New state is #{inspect(new_state)}")
        listen_loop(new_state)

      {sender, :recent_pledges} ->
        send(sender, {:response, state})
        IO.puts("Sent pledges to #{inspect(sender)}")
        listen_loop(state)
    end
  end

  def create_pledge(pid, name, amount) do
    send(pid, {:create_pledge, name, amount})
  end

  def recent_pledges(pid) do
		send pid, {self(), :recent_pledges}

		receive do {:response, pledges} -> pledges end
  end

  defp send_pledge_to_service(_name, _amount) do
    # Send pledge to external service:
    {:ok, "pledge-#{:rand.uniform(1000)}}"}
  end
end

alias Servy.PledgeServer

pid = spawn(PledgeServer, :listen_loop, [[]])

PledgeServer.create_pledge(pid, "larry", 10)
PledgeServer.create_pledge(pid, "moe", 20)
PledgeServer.create_pledge(pid, "curly", 30)
PledgeServer.create_pledge(pid, "daisy", 40)
PledgeServer.create_pledge(pid, "grace", 50)

IO.inspect PledgeServer.recent_pledges(pid)
