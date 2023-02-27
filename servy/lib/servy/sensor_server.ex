defmodule Servy.SensorServer do
  
  @name :sensor_server

  use GenServer

  # Client Interface

  def start do
    GenServer.start(__MODULE__, %{}, name: @name)
  end
  
  def get_sensor_data do
    GenServer.call @name, get_sensor_data
  end

  # Server Callbacks

  def init(_state) do
    initial_state = run_tasks_to_get_sensor_data()
    {:ok, initial_state}
  end

  def handle_call(:get_sensor_data, _from, state) do
    {:reply, state, state}
  end

end
