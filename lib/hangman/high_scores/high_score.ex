defmodule Hangman.HighScores.HighScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "high_scores" do
    field :value, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(high_score, attrs) do
    high_score
    |> cast(attrs, [:value, :user_id])
    |> validate_required([:value])
  end
end
