defmodule Servy.BearController do
  def index(conv) do
    %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
  end

  def show(conv) do
    %{ conv | status: 200, resp_body: "Bear #{id}" }
  end
end
