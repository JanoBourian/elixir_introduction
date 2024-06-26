defmodule Maxine.Repo.Migrations.CreateBears do
  use Ecto.Migration

  def change do
    create table(:bears) do
      add :name, :string
      add :type, :string
      add :hibernating, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
