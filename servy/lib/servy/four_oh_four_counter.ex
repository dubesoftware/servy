defmodule Servy.FourOhFourCounter do

  @name :four_oh_four_counter

  # Client Interface

  def start do
    IO.puts "Starting the 404 counter..."
    pid = spawn(__MODULE__, :listen_loop, [%{}])
    Process.register(pid, @name)
    pid
  end

  def bump_count(path) do
    call @name, {:bump_count, path}
  end

  def get_counts do
    call @name, :get_counts
  end

  def get_count(path) do
    call @name, {:get_count, path}
  end

  def reset do
    cast @name, :reset
  end

  # Helper Functions

  def call(pid, message) do
    send pid, {:call, self(), message}

    receive do {:response, response} -> response end
  end

  def cast(pid, message) do
    send pid, {:cast, message}
  end

  # Server

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
        IO.puts "Unexpected messaged: #{inspect unexpected}"
        listen_loop(state)
    end
  end

  def handle_call({:bump_count, path}, state) do
    new_state = Map.update(state, path, 1, &(&1 + 1))
    {:ok, new_state}
  end

  def handle_call(:get_counts, state) do
    {state, state}
  end

  def handle_call({:get_count, path}, state) do
    count = Map.get(state, path, 0)
    {count, state}
  end

  def handle_cast(:reset, _state) do
    %{}
  end
end
