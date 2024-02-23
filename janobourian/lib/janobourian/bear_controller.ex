defmodule Janobourian.BearController do

  alias Janobourian.Conv

  def index(%Conv{} = conv) do
    %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}
  end

  def show(%Conv{} = conv, %{"id" => id} = _params) do
    %{ conv | status: 200, resp_body: "Bear #{id}"}
  end

  def create(%Conv{} = conv, %{ "type" => type, "name" => name} = _params) do
    %{ conv | status: 200, resp_body: "Created a #{type} bear named #{name}"}
  end
end
