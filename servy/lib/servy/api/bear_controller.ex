defmodule Servy.Api.BearController do
  
  def index(conv) do
    json =
      Servy.Wildthings.list_bears()
      |> Poison.encode!
    
    new_headers = Map.put(conv.resp_headers, "Content-Type", json)

    %{ conv | status: 200, resp_headers: new_headers, resp_body: json }
  end

  defp put_resp_content_type(conv, content_type) do
    new_headers = Map.put(conv, "Content-Type", content_type)
    %{ conv | resp_headers: new_headers }
  end

end
