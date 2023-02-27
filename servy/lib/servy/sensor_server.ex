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

end
