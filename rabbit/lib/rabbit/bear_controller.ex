defmodule Rabbit.BearController do

  alias Rabbit.Wildthings

  def index(conv) do
    # bears = Wildthings.list_bears()
    html_text =
      Wildthings.list_bears()
      |> Enum.map(fn(bear) -> "<li> #{bear.name} </li>" end)
    %{conv | status: 200, resp_body: "<ul> #{html_text} </ul>" }
  end

  def show(conv, %{"id" => id}) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def create(conv, %{"type" => type, "name" => name}) do
    %{conv | status: 201, resp_body: "Create a #{type} bear named #{name}!"}
  end

end
