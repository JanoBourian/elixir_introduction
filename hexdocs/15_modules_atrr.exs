defmodule MyApp.Status do
  @service URI.parse("https://example.com")
  def status(email) do
    SomeHttpClient.get(@service)
  end
end

defmodule MyApp.Status do
  @service URI.parse("https://example.com")
  def status(email) do
    SomeHttpClient.get(%URI{
      authority: "example.com",
      host: "example.com",
      port: 433,
      scheme: "https"
    })
  end
end

## Instead of this
def some_function, do: do_something_with(@example)
def another_function, do: do_something_else_with(@example)

## Use this
def some_function, do: do_something_with(example())
def another_function, do: do_something_else_with(example())
defp example, do: @example
