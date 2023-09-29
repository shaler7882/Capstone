defmodule Hangman.Repo.Migrations.CreateHighScores do
  use Ecto.Migration

  def change do
    create table(:high_scores) do
      add :value, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:high_scores, [:user_id])
  end
end
