require 'spec_helper'

describe Match do
  it "should have valid factory" do
    m = FactoryGirl.build(:match)
    FactoryGirl.build(:match).should be_valid
  end

  describe "rating" do
    it "should be > if > goals" do
      @match_1 = FactoryGirl.build(:match, :goals_1 => 2, :goals_2 => 2)
      @match_2 = FactoryGirl.build(:match, :goals_1 => 1, :goals_2 => 1)

      @match_1.calculate_rating.should > @match_2.calculate_rating
    end

    it "shoud be > if goals diff is <" do
      @match_1 = FactoryGirl.build(:match, :goals_1 => 1, :goals_2 => 1)
      @match_2 = FactoryGirl.build(:match, :goals_1 => 0, :goals_2 => 2)

      @match_1.calculate_rating.should > @match_2.calculate_rating
    end

    it "should be > if unexpected result" do
      @match_1 = FactoryGirl.build(:match, :team_1_odds => 3.0, :draw_odds => 2.0, :team_2_odds => 3.0, :goals_1 => 0, :goals_2 => 1)
      @match_2 = FactoryGirl.build(:match, :team_1_odds => 3.0, :draw_odds => 2.0, :team_2_odds => 1.0, :goals_1 => 0, :goals_2 => 1)

      @match_1.calculate_rating.should > @match_2.calculate_rating
    end

  end

end
