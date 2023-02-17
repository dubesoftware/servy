defmodule Servy.Fetcher do
  def async(fun) do
    parent = self()

    spawn(fn -> send(parent, {self(), :result, fun.()}) end)
  end

  def get_result(pid) do
    receive do 
      {^pid, :result, value} -> value
    after :timer.seconds(2) ->
      raise "Timed out!"
    end
  end

end