defmodule Servy.PowerNapper do
  power_nap = fn ->
    time = :rand.uniform(10_000)
    :timer.sleep(time)
    time
  end
end
