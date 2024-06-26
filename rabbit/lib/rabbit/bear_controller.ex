defmodule Rabbit.BearController do

  alias Rabbit.Bear
  alias Rabbit.Wildthings

  @templates_path Path.expand("../../templates", __DIR__)

  def index(conv) do
    # bears = Wildthings.list_bears()
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    render(conv, "index.eex", [bears: bears])
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    render(conv, "show.eex", [bear: bear])
  end

  def create(conv, %{"type" => type, "name" => name}) do
    %{conv | status: 201, resp_body: "Create a #{type} bear named #{name}!"}
  end

  defp render(conv, template, bindings \\ []) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{conv | status: 200, resp_body: content}
  end

end
