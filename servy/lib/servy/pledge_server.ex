defmodule Servy.PledgeServer do
	
	@name :pledge_server

	use GenServer
	
	# Client Interface
	
	def start do
		IO.puts "Starting the pledge server..."
		GenServer.start(__MODULE__, [], name: @name)
	end

  def create_pledge(name, amount) do
    GenServer.call @name, {:create_pledge, name, amount}
  end

  def recent_pledges do
		GenServer.call @name, :recent_pledges
  end
	
  def total_pledged do
		GenServer.call @name, :total_pledged
  end
	
	def clear do
		GenServer.cast @name, :clear
	end
	
	# Server Callbacks
	
	def handle_cast(:clear, _state) do
		{:noreply, []}
	end
	
	def handle_call(:total_pledged, _from, state) do
		total = Enum.map(state, &elem(&1, 1)) |> Enum.sum
		{:reply, total, state}
	end
	
	def handle_call(:recent_pledges, _from, state) do
		{:reply, state, state}
	end
	
	def handle_call({:create_pledge, name, amount}, state) do
    {:ok, id} = send_pledge_to_service(name, amount)
		most_recent_pledges = Enum.take(state, 2)
    new_state = [{name, amount} | most_recent_pledges]
		{:reply, id, new_state}
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
