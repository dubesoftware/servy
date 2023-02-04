defmodule Servy.Capture do
  def add do
    fn(a, b) -> a + b end
  end

  def shorthand_add do
    &(&1 + &2)
  end

  def duplicate_string do
    fn(s, n) -> String.duplicate(s, n)
  end
  end
end

IO.inspect Servy.Capture.add.(1, 2)
IO.inspect Servy.Capture.shorthand_add.(3, 4)

IO.inspect Servy.Capture.duplicate_string.("Hello, world!", 1)