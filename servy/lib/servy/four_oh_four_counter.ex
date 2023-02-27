defmodule Servy.FourOhFourCounter do

  @name :four_oh_four_counter

  use GenServer

  # Client Interface

  def start do
    IO.puts "Starting the 404 counter..."
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  def bump_count(path) do
    GenServer.call @name, {:bump_count, path}
  end

  def get_counts do
    GenServer.call @name, :get_counts
  end

  def get_count(path) do
    GenServer.call @name, {:get_count, path}
  end

  def reset do
    GenServer.cast @name, :reset
  end

  # Server Callbacks

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
