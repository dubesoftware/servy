defmodule Servy.PledgeServer do
	
	@name __MODULE__
	
	# Client Interface
	
	def start(initial_state \\ []) do
		IO.puts "Starting the pledge server..."
		pid = spawn(__MODULE__, :listen_loop, [initial_state])
		Process.register(pid, @name)
		pid
	end

  def create_pledge(name, amount) do
    call @name, {:create_pledge, name, amount}
  end

  def recent_pledges do
		call @name, :recent_pledges
  end
	
  def total_pledged do
		call @name, :total_pledged
  end
	
	def call(pid, message) do
    send pid, {self(), message}
		
		receive do {:response, response} -> response end
	end
	
	# Server
	
  def listen_loop(state) do
    receive do
			{sender, message} ->
				response = handle_call(message, state)
				send sender, {:response, response}
				listen_loop(state)
      {sender, {:create_pledge, name, amount}} ->
        {:ok, id} = send_pledge_to_service(name, amount)
				most_recent_pledges = Enum.take(state, 2)
        new_state = [{name, amount} | most_recent_pledges]
				send sender, {:response, id}
        listen_loop(new_state)
			unexpected ->
				IO.puts "Unexpected message: #{inspect unexpected}"
				listen_loop(state)
    end
  end
	
	def handle_call(:total_pledged, state) do
		total = Enum.map(state, &elem(&1, 1)) |> Enum.sum
	end
	
	def handle_call(:recent_pledges, state) do
		state
	end

  defp send_pledge_to_service(_name, _amount) do
    {:ok, "pledge-#{:rand.uniform(1000)}"}
  end
end

alias Servy.PledgeServer

pid = PledgeServer.start()

IO.inspect PledgeServer.create_pledge("larry", 10)
IO.inspect PledgeServer.create_pledge("moe", 20)
IO.inspect PledgeServer.create_pledge("curly", 30)
IO.inspect PledgeServer.create_pledge("daisy", 40)
IO.inspect PledgeServer.create_pledge("grace", 50)

IO.inspect PledgeServer.recent_pledges()

IO.inspect PledgeServer.total_pledged()
