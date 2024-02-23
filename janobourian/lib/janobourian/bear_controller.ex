defmodule Janobourian.BearController do

  alias Janobourian.Conv
  alias Janobourian.Wildthings
  alias Janobourian.Bear

  @templates_path Path.expand("../../templates", __DIR__)

  def index(%Conv{} = conv) do
    bears =
      Wildthings.list_bears()
      # |> Enum.filter(&Bear.is_grizzly/1)
      |> Enum.sort(&Bear.order_asc_by_name/2)
      # |> Enum.map(&bear_item/1)
      # |> Enum.join()

      render(conv, "show.eex", [bears: bears])
  end

  def show(%Conv{} = conv, %{"id" => id} = _params) do
    bear = Wildthings.get_bear(id)
    render(conv, "show.eex", [bear: bear])
  end

  def create(%Conv{} = conv, %{ "type" => type, "name" => name} = _params) do
    %{ conv | status: 200, resp_body: "Created a #{type} bear named #{name}"}
  end

  defp render(conv, template, bindings \\ []) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{ conv | status: 200, resp_body: content}
  end

  # defp bear_item(bear) do
  #   "<li>#{bear.name} - #{bear.type}</li>"
  # end
end
