defmodule Hangman do
  def new_game do
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

    winning_word = Enum.random(list_of_words)
    new_word = [""]
    guesses = []
    attempts = 6
    Hangman.make_guess(winning_word, new_word, guesses, attempts)
  end

  def display_game(_winning_word, new_word, guesses, attempts) do
    masked_word = new_word |> Enum.map(&mask_letter(&1, guesses))
    masked_word |> Enum.join(" ") |> IO.puts()
    IO.puts("Guesses left: #{attempts}")
  end

  def make_guess(word, new_word, guesses, 0) do
    display_game(word, new_word, guesses, 0)
    IO.puts("Game over. The word was #{word}.")
  end

  def make_guess(word, word_new, guesses, attempts) do
    display_game(word, word_new, guesses, attempts)
    IO.write("Enter your guess: ")
    guess = String.downcase(IO.gets("")) |> String.trim()
    new_guesses = [guess | guesses]

    case String.contains?(word, guess) do
      true ->
        new_word =
          word
          |> String.graphemes()
          |> Enum.reduce([], fn
            letter, acc ->
              if letter == guess or letter in new_guesses do
                [letter | acc]
              else
                ["_" | acc]
              end
          end)
          |> Enum.reverse()

        if Enum.join(new_word) == word do
          IO.puts("Congratulations! You guessed the word: #{word}")
        else
          make_guess(word, new_word, new_guesses, attempts)
        end

      false ->
        new_attempts = attempts - 1

        make_guess(word, word_new, new_guesses, new_attempts)
    end
  end

  defp mask_letter(letter, guesses) do
    Enum.find_value(guesses, fn
      element -> if element == letter, do: letter
    end)
  end
end
