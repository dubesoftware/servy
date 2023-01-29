defmodule Servy.Recurse do
  def sum([head | tail], total) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"
    total = total + head
    sum(tail, total)
  end

  def sum([], total), do: total

  def triple([head | tail], tripled) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"
    tripled = [tripled, head * 3]
    triple(tail, tripled)
  end

  def triple([], tripled), do: List.flatten(tripled)
end
  
IO.inspect Servy.Recurse.sum([1, 2, 3, 4, 5], 0)

IO.inspect Servy.Recurse.triple([1, 2, 3, 4, 5], [])