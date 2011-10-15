class AddFullNameToTeams < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.string :full_name
    end
  end
end
