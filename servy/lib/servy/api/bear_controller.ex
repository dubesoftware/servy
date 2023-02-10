defmodule Servy.Api.BearController do
  
  def index(conv) do
    json =
      Servy.Wildthings.list_bears()
      |> Poison.encode!
    
    conv = put_resp_content_type(conv, "application/json")

    %{ conv | status: 200, resp_body: json }
  end

  def put_content_length(conv) do
    new_headers = Map.put(conv.resp_headers, "Content-Length", String.length(conv.resp_body))
    %{ conv | resp_headers: new_headers }
  end

  defp put_resp_content_type(conv, type) do
    new_headers = Map.put(conv.resp_headers, "Content-Type", type)
    %{ conv | resp_headers: new_headers }
  end

end
