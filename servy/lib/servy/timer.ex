defmodule Servy.Timer do
  
  def remind(reminder, seconds_in_future) do
    seconds_in_future
      |> String.to_integer
      |> :timer.sleep
    
    IO.puts reminder
  end

end
