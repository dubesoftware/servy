defmodule Servy.Capture do
  def add do
    fn(a, b) -> a + b end
  end

  def shorthand_add do
    &(&1 + &2)
  end

  def repeat do
    &String.duplicate(&1, &2)
  end

  def shorthand_repeat do
    &String.duplicate/2
  end
end

IO.inspect Servy.Capture.add.(1, 2)
IO.inspect Servy.Capture.shorthand_add.(3, 4)

IO.inspect Servy.Capture.repeat.("Hello, world!", 1)
IO.inspect Servy.Capture.shorthand_repeat.("Hello, world!", 2)
