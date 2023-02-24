defmodule Servy.GenericServer do
	def call(pid, message) do
    send pid, {:call, self(), message}
		
		receive do {:response, response} -> response end
	end
	
	def cast(pid, message) do
		send pid, {:cast, message}
	end
	
  def listen_loop(state) do
    receive do
			{:call, sender, message} when is_pid(sender) ->
				{response, new_state} = handle_call(message, state)
				send sender, {:response, response}
				listen_loop(new_state)
			{:cast, message} ->
				new_state = handle_cast(message, state)
				listen_loop(new_state)
			unexpected ->
				IO.puts "Unexpected message: #{inspect unexpected}"
				listen_loop(state)
    end
  end
end

defmodule Servy.PledgeServer do
	
	@name __MODULE__
	
	alias Servy.GenericServer
	
	# Client Interface
	
	def start(initial_state \\ []) do
		IO.puts "Starting the pledge server..."
		pid = spawn(__MODULE__, :listen_loop, [initial_state])
		Process.register(pid, @name)
		pid
	end

  def create_pledge(name, amount) do
    GenericServer.call @name, {:create_pledge, name, amount}
  end

  def recent_pledges do
		GenericServer.call @name, :recent_pledges
  end
	
  def total_pledged do
		GenericServer.call @name, :total_pledged
  end
	
	def clear do
		GenericServer.cast @name, :clear
	end
	
	# Server
	
	def handle_cast(:clear, _state) do
		[]
	end
	
	def handle_call(:total_pledged, state) do
		total = Enum.map(state, &elem(&1, 1)) |> Enum.sum
		{total, state}
	end
	
	def handle_call(:recent_pledges, state) do
		{state, state}
	end
	
	def handle_call({:create_pledge, name, amount}, state) do
    {:ok, id} = send_pledge_to_service(name, amount)
		most_recent_pledges = Enum.take(state, 2)
    new_state = [{name, amount} | most_recent_pledges]
		{id, new_state}
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

PledgeServer.clear()

IO.inspect PledgeServer.create_pledge("grace", 50)

IO.inspect PledgeServer.recent_pledges()

IO.inspect PledgeServer.total_pledged()
