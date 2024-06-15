defmodule Maxine.Repo do
  use Ecto.Repo,
    otp_app: :maxine,
    adapter: Ecto.Adapters.Postgres
end
