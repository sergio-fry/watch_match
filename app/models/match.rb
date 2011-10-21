class Match < ActiveRecord::Base
  scope :recent, lambda { where("began_on > ?", 30.days.ago) }
  belongs_to :league
  belongs_to :team_1, :class_name => "Team", :foreign_key => :team_1_id
  belongs_to :team_2, :class_name => "Team", :foreign_key => :team_2_id

  before_save :calculate_rating

  validates :league_id, :presence => true
  validates :team_1_id, :presence => true
  validates :team_2_id, :presence => true
  validates :team_1_odds, :presence => true, :numericality => { :greater_than => 0 }
  validates :team_2_odds, :presence => true, :numericality => { :greater_than => 0 }
  validates :draw_odds, :presence => true, :numericality => { :greater_than => 0 }
  validates :goals_1, :presence => true
  validates :goals_2, :presence => true
  validates :half_goals_1, :presence => true
  validates :half_goals_2, :presence => true
  validates :began_on, :presence => true, :uniqueness => { :scope => [:team_1_id] }

  def calculate_rating
    self.rating = 3 * goals_k + goals_diff_k + 5 * odds_k + 2 * interesting_finish_k + early_goals_k
  end

  private

  def early_goals_k
    1.0 - 1.0 / (1.0 + ((half_goals_2) + (half_goals_1)).abs.to_f)
  end

  def interesting_finish_k
    1.0 - 1.0 / (1.0 + ((goals_2 - half_goals_2) + (goals_1 - half_goals_1)).abs.to_f)
  end

  def goals_diff_k
    1.0 / (1.0 + (goals_2 - goals_1).abs.to_f)
  end

  def goals_k
    1.0 - 1.0 / (goals_1 + goals_2 + 1.0).to_f
  end

  def odds_k
    k = result_odds.to_f / [team_1_odds, team_2_odds, draw_odds].max.to_f
    x = result_odds.to_f

    k * (1.0 - 1.0 / (x + 1.0))
  end

  def result_odds
    if goals_1 > goals_2
      team_1_odds
    elsif goals_1 < goals_2
      team_2_odds
    else
      draw_odds
    end
  end
end
