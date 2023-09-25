defmodule HangmanWeb.GameLive do
  use HangmanWeb, :live_view

  def mount(params, session, socket) do
    list_of_words = [
      "elixir"
      # "strings",
      # "booleans",
      # "atoms",
      # "tuples",
      # "lists",
      # "maps",
      # "functions"
    ]

    winning_word = Enum.random(list_of_words)
    {:ok, assign(socket, winning_word: winning_word, guesses: ["e", "i"], lives: 6)}
  end

  def render(assigns) do
    ~H"""
    <%= for char <- String.graphemes(@winning_word) do %>
      <%= if char in @guesses, do: char, else: "_" %>
    <% end %>

    <.form for={%{}} phx-submit="enter_guess">
      <.input name="guess" value="" />
    </.form>

    <%= for char <- String.graphemes("ABCDEFGHIJKLMNOPQRSTUVWXYZ") do %>
    <.button phx-click="enter_guess" phx-value-guess={String.downcase(char)}> <%= char %> </.button>
    <% end %>
    """
  end

  def handle_event("enter_guess", unsigned_params, socket) do
    IO.inspect(unsigned_params)
    %{"guess" => guess} = unsigned_params
    {:noreply, assign(socket, guesses: [guess | socket.assigns.guesses])}
  end
end
