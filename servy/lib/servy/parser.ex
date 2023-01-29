defmodule Servy.Parser do

  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request_line | header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines)
    params = parse_params(params_string)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_headers([head | tail]) do
    parse_headers(tail)
  end
  
  def parse_headers([]), do: IO.puts "Done!"

  def parse_params(params_string) do
    params_string |> String.trim |> URI.decode_query
  end
end