class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :code
      t.boolean :visible

      t.timestamps
    end
  end
end
