defmodule Servy.PledgeController do
  
  def create(conv, %{"name" => name, "amount" => amount}) do
    # Send the pledge to the external service and caches it
    create_pledge(name, String.to_integer(amount))

    %{ conv | status: 201, resp_body: "#{name} pledged #{amount}!" }
  end

end