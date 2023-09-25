defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def game(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :game, layout: false)
  end
end
