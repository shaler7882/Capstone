defmodule HangmanWeb.GameLive do
  use HangmanWeb, :live_view
  import Ecto.Query, warn: false
  alias Hangman.Repo

  alias Hangman.Accounts.{User, UserToken, UserNotifier}

  def mount(params, session, socket) do
    list_of_words = [
      "elixir",
      "strings",
      "booleans",
      "atoms",
      "tuples",
      "lists",
      "maps",
      "functions"
    ]

    winning_word = String.downcase(Faker.Vehicle.make())
    {:ok, assign(socket, winning_word: winning_word, guesses: [], lives: 6, result: false, body_img: "/images/post.jpg", high_score: 0)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= if @result do %>
        <.link href="/game">
          <.button class="win">WINNER<br />Play Again</.button>
        </.link>
      <% end %>
    </div>
    <div>
      <%= if @lives == 0 do %>
        <.link href="/game">
          <.button class="win">LOSER<br />Play Again</.button>
        </.link>
      <% end %>
    </div>
    <div class="lives">Lives Left = <%= @lives %></div>
    <div class="high">Score <%= @high_score %></div>
    <img class="pic" src={@body_img}>
    <div class="word">
      <%= for char <- String.graphemes(@winning_word) do %>
        <%= if char in @guesses, do: char, else: "_" %>
      <% end %>
    </div>
    <div class="guess">
      <%= for char <- String.graphemes("ABCDEFGHIJKLMNOPQRSTUVWXYZ") do %>
        <%= if String.downcase(char) in @guesses do %>
          <.button></.button>
        <% else %>
          <.button phx-click="enter_guess" phx-value-guess={String.downcase(char)}>
            <%= char %>
          </.button>
        <% end %>
      <% end %>
    </div>
    """
  end

  def handle_event("enter_guess", unsigned_params, socket) do
    %{"guess" => guess} = unsigned_params
    guesses = [guess | socket.assigns.guesses]

    minus_life =
      Enum.member?(String.graphemes(socket.assigns.winning_word), guess)

    lives = if minus_life, do: socket.assigns.lives, else: socket.assigns.lives - 1

    high_score = if minus_life, do: socket.assigns.high_score + 100, else: socket.assigns.high_score

    body_part =
      case lives do
        6 -> "/images/post.jpg"
        5 -> "/images/head.jpg"
        4 -> "/images/body.jpg"
        3 -> "/images/rightarm.jpg"
        2 -> "/images/leftarm.jpg"
        1 -> "/images/rightleg.jpg"
        0 -> "/images/leftleg.jpg"
        _ -> ""
      end

    is_winner =
      Enum.all?(String.graphemes(socket.assigns.winning_word), fn each -> each in guesses end)
    
    {:noreply, assign(socket, guesses: guesses, result: is_winner, lives: lives, body_img: body_part, high_score: high_score)}
  end
end
