class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :team_1_id
      t.integer :team_2_id
      t.date :began_on
      t.integer :goals_1
      t.integer :goals_2

      t.timestamps
    end
  end
end
