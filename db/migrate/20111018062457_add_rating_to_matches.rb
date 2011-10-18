class AddRatingToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :rating, :float
    add_index :matches, :rating
  end
end
