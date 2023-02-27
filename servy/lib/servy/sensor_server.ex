defmodule Servy.SensorServer do
  
  @name :sensor_server

  use GenServer

  # Client Interface

  def start do
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  # Server Callbacks

end
