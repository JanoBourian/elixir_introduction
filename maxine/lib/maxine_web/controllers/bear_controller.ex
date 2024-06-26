defmodule MaxineWeb.BearController do
  use MaxineWeb, :controller

  alias Maxine.Wildthings
  alias Maxine.Wildthings.Bear

  def index(conn, _params) do
    bears = Wildthings.list_bears()
    render(conn, :index, bears: bears)
  end

  def new(conn, _params) do
    changeset = Wildthings.change_bear(%Bear{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"bear" => bear_params}) do
    case Wildthings.create_bear(bear_params) do
      {:ok, bear} ->
        conn
        |> put_flash(:info, "Bear created successfully.")
        |> redirect(to: ~p"/bears/#{bear}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bear = Wildthings.get_bear!(id)
    render(conn, :show, bear: bear)
  end

  def edit(conn, %{"id" => id}) do
    bear = Wildthings.get_bear!(id)
    changeset = Wildthings.change_bear(bear)
    render(conn, :edit, bear: bear, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bear" => bear_params}) do
    bear = Wildthings.get_bear!(id)

    case Wildthings.update_bear(bear, bear_params) do
      {:ok, bear} ->
        conn
        |> put_flash(:info, "Bear updated successfully.")
        |> redirect(to: ~p"/bears/#{bear}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, bear: bear, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bear = Wildthings.get_bear!(id)
    {:ok, _bear} = Wildthings.delete_bear(bear)

    conn
    |> put_flash(:info, "Bear deleted successfully.")
    |> redirect(to: ~p"/bears")
  end
end
