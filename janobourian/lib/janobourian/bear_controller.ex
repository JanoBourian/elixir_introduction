defmodule Janobourian.BearController do

  alias Janobourian.Conv
  alias Janobourian.Wildthings
  alias Janobourian.Bear

  def index(%Conv{} = conv) do
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_grizzly/1)
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Enum.map(&bear_item/1)
      |> Enum.join()
    %{ conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(%Conv{} = conv, %{"id" => id} = _params) do
    bear = Wildthings.get_bear(id)
    %{ conv | status: 200, resp_body: "<h1>Bear #{bear.id}: #{bear.name}</h1>"}
  end

  def create(%Conv{} = conv, %{ "type" => type, "name" => name} = _params) do
    %{ conv | status: 200, resp_body: "Created a #{type} bear named #{name}"}
  end

  defp bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end
end
