defmodule ParserTest do
  use ExUnit.Case
  doctest Servy.Parser

  alias Servy.Parser

  test "greets the world" do
    assert Parser.hello() == :world
  end
end
