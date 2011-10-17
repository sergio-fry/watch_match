class AddHalfGoalsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :half_goals_1, :integer
    add_column :matches, :half_goals_2, :integer
  end
end
