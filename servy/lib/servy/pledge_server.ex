defmodule Servy.PledgeServer do
  def listen_loop(state) do
    IO.puts("\nWaiting for a message...")

    receive do
      {:create_pledge, name, amount} ->
        {:ok, id} = send_pledge_to_service(name, amount)
        new_state = [{name, amount} | state]
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

  # def recent_pledges do
  # 	# Returns the most recent pledges (cache):
  # 	[ {"larry", 10} ]
  # end

  defp send_pledge_to_service(_name, _amount) do
    # Send pledge to external service:
    {:ok, "pledge-#{:rand.uniform(1000)}}"}
  end
end

alias Servy.PledgeServer

pid = spawn(PledgeServer, :listen_loop, [[]])

send(pid, {:create_pledge, "larry", 10})
send(pid, {:create_pledge, "moe", 20})
send(pid, {:create_pledge, "curly", 30})
send(pid, {:create_pledge, "daisy", 40})
send(pid, {:create_pledge, "grace", 50})

send(pid, {self(), :recent_pledges})

receive do
  {:response, pledges} -> IO.inspect(pledges)
end
