defmodule Hangman.HighScoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hangman.HighScores` context.
  """

  @doc """
  Generate a high_score.
  """
  def high_score_fixture(attrs \\ %{}) do
    {:ok, high_score} =
      attrs
      |> Enum.into(%{
        value: 42
      })
      |> Hangman.HighScores.create_high_score()

    high_score
  end
end
