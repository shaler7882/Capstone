defmodule Hangman.HighScoresTest do
  use Hangman.DataCase

  alias Hangman.HighScores

  describe "high_scores" do
    alias Hangman.HighScores.HighScore

    import Hangman.HighScoresFixtures
    import Hangman.AccountsFixtures

    @invalid_attrs %{value: nil}

    test "list_high_scores/0 returns all high_scores" do
      high_score = high_score_fixture()
      assert HighScores.list_high_scores() == [high_score]
    end

    test "get_high_score!/1 returns the high_score with given id" do
      high_score = high_score_fixture()
      assert HighScores.get_high_score!(high_score.id) == high_score
    end

    test "get_user_high_score!/1 returns the high_score with given id" do
      user = user_fixture()
      high_score = high_score_fixture(user_id: user.id)
      IO.inspect(high_score, label: "^^^^^^^^")
      assert HighScores.get_user_high_score(user.id) == high_score
    end

    test "create_high_score/1 with valid data creates a high_score" do
      valid_attrs = %{value: 42}

      assert {:ok, %HighScore{} = high_score} = HighScores.create_high_score(valid_attrs)
      assert high_score.value == 42
    end

    test "create_high_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HighScores.create_high_score(@invalid_attrs)
    end

    test "update_high_score/2 with valid data updates the high_score" do
      high_score = high_score_fixture()
      update_attrs = %{value: 43}

      assert {:ok, %HighScore{} = high_score} = HighScores.update_high_score(high_score, update_attrs)
      assert high_score.value == 43
    end

    test "update_high_score/2 with invalid data returns error changeset" do
      high_score = high_score_fixture()
      assert {:error, %Ecto.Changeset{}} = HighScores.update_high_score(high_score, @invalid_attrs)
      assert high_score == HighScores.get_high_score!(high_score.id)
    end

    test "delete_high_score/1 deletes the high_score" do
      high_score = high_score_fixture()
      assert {:ok, %HighScore{}} = HighScores.delete_high_score(high_score)
      assert_raise Ecto.NoResultsError, fn -> HighScores.get_high_score!(high_score.id) end
    end

    test "change_high_score/1 returns a high_score changeset" do
      high_score = high_score_fixture()
      assert %Ecto.Changeset{} = HighScores.change_high_score(high_score)
    end
  end
end
