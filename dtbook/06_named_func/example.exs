defmodule Example do

  @author "Dave Thomas"

  def compile_and_go(source) do
    alias My.Other.Module.Parser, as: Parser
    alias My.Other.Module.Runner, as: Runner

    source
    |> Parser.parse()
    |> Runner.execute()
  end

  def get_author do
    @author
  end
end
