defmodule Servy do
  def hello(name \\ "world") do
    "Howdy, #{name}!"
  end
end

# IO.puts Servy.hello("Elixir")
