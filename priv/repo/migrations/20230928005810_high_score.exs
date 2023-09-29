defmodule Hangman.Repo.Migrations.HighScore do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :high_score, :integer
    end
  end
end
