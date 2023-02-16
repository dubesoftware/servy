defmodule Servy.PowerNapper do
  def power_nap do
    time = :rand.uniform(10_000)
    :timer.sleep(time)
    time
  end
end
