defmodule Janobourian.Conv do
  defstruct [
    method: "",
    path: "",
    resp_body: "",
    status: nil,
    params: %{},
    headers: %{}
  ]
end