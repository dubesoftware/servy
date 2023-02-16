defmodule Servy.PowerNapperClient do
  alias Servy.PowerNapper

  parent = self()
  spawn(fn -> send(parent, {:slept, PowerNapper.power_nap.()}) end)

  receive do
    {:slept, time} -> IO.puts "Slept #{time} ms"
  end
end