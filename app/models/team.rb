class Team < ActiveRecord::Base
  has_many :home_matches, :class_name => "Match", :foreign_key => :team_1_id
  has_many :out_matches, :class_name => "Match", :foreign_key => :team_2_id

  validate :name, :presence => true
end
