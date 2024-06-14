defmodule Rabbit.Bear do
  @moduledoc """
  Module with the Bear structure
  """

  defstruct id: nil, name: "", type: "", hibernating: false

  def is_grizzly(bear) do
    bear.type == "Grizzly"
  end

  def order_asc_by_name(bear1, bear2) do
    bear1.name <= bear2.name
  end

end
