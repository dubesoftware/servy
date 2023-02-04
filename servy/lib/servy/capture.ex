defmodule Servy.Capture do
  def add do
    fn(a, b) -> a + b end
  end
end

IO.inspect Servy.Capture.add.(1, 2)