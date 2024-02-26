defmodule Janobourian.Api.BearController do

  alias Janobourian.Conv

  def index(%Conv{} = conv) do
    json =
      Janobourian.Wildthings.list_bears()
      |> Poison.encode!()

    %{ conv | status: 200, resp_body: json, response_content_type: "application/json" }
  end
end
