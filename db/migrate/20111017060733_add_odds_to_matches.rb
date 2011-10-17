class AddOddsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :team_1_odds, :float
    add_column :matches, :team_2_odds, :float
    add_column :matches, :draw_odds, :float
  end
end
