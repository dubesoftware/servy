defmodule Servy.PledgeServer do
  def create_pledge(name, amount) do
    %{:ok, id} = send_pledge_to_service(name, amount)
  end

  defp send_pledge_to_service(_name, _amount) do
    # Return recent pledges from cache here
  end
end
