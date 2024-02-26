defmodule Janobourian.Conv do
  defstruct [
    method: "",
    path: "",
    resp_body: "",
    status: nil,
    response_content_type: "text/html",
    params: %{},
    headers: %{}
  ]
end
