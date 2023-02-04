defmodule Servy.BearController do

  alias Servy.Wildthings
  alias Servy.Bear

  @templates_path Path.expand("../../templates", File.cwd!)

  def index(conv) do
    items =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    %{ conv | status: 200, resp_body: "<ul>#{items}</ul>" }
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{ conv | status: 200, resp_body: "<h1>Bear #{bear.id}: #{bear.name}</h1>" }
  end

  def create(conv, %{"name" => name, "type" => type} = params) do
    %{ conv | status: 201, resp_body: "Created a #{type} bear named #{name}!" }
  end

  def delete(conv, _params) do
    %{ conv | status: 403, resp_body: "Bears must never be deleted!"}
  end
end
