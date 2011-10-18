class Match < ActiveRecord::Base
  belongs_to :league
  belongs_to :team_1, :class_name => "Team", :foreign_key => :team_1_id
  belongs_to :team_2, :class_name => "Team", :foreign_key => :team_2_id

  validates :league_id, :presence => true
  validates :team_1_id, :presence => true
  validates :team_2_id, :presence => true
  validates :began_on, :presence => true, :uniqueness => { :scope => [:team_1_id] }
end
