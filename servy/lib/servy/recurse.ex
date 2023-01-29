defmodule Servy.Recurse do
  def sum([head | tail], total) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"
    total = total + head
    sum(tail, total)
  end

  def sum([], total), do: total
end
  
IO.puts Servy.Recurse.sum([1, 2, 3, 4, 5], 0)