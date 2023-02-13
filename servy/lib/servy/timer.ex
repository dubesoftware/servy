defmodule Servy.Timer do
  
  def remind(reminder, seconds) do
    seconds
      |> String.to_integer
      |> :timer.sleep
    
    IO.puts reminder
  end

end

:timer.sleep(:infinity)
