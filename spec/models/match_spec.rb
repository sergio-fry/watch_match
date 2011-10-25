require 'spec_helper'

describe Match do
  it "should have valid factory" do
    m = FactoryGirl.build(:match)
    FactoryGirl.build(:match).should be_valid
  end

  describe "validation" do
    %w(team_1_odds team_2_odds draw_odds).each do |attr|
      it "should not be valid if #{attr} are empty" do
        FactoryGirl.build(:match, attr => nil).should_not be_valid
      end
    end

    %w(team_1_odds team_2_odds draw_odds).each do |attr|
      it "should not be valid if #{attr} = 0" do
        FactoryGirl.build(:match, attr => 0).should_not be_valid
      end
    end
  end

  describe "rating" do

    describe "goals_diff_k" do
      it "should be = 1 if diff = 0" do
        FactoryGirl.build(:match, :goals_1 => 1, :goals_2 => 1).
          send(:goals_diff_k).should == 1
      end

      it "should be small if diff is large" do
        FactoryGirl.build(:match, :goals_1 => 0, :goals_2 => 5).
          send(:goals_diff_k).should < 0.2
      end
    end

    describe "goals_k" do
      it "should be = 0 if no golas" do
        FactoryGirl.build(:match, :goals_1 => 0, :goals_2 => 0).
          send(:goals_k).should == 0
      end

      it "should be near 1 if lot of golas" do
        FactoryGirl.build(:match, :goals_1 => 10).
          send(:goals_k).should > 0.8
      end
    end

    describe "odds_k" do
      it "should be near 0 if result is was excpected" do
        FactoryGirl.build(:match, :goals_1 => 1, :goals_2 => 0,
                          :team_1_odds => 1.0, :team_2_odds => 6.0, :draw_odds => 3.0).
                          send(:odds_k).should < 0.2
      end

      it "should be near 1 if result is was unexcpected" do
        k = FactoryGirl.build(:match, :goals_1 => 1, :goals_2 => 0,
                              :team_1_odds => 6.0, :team_2_odds => 1.0, :draw_odds => 3.0).
                              send(:odds_k)

        (1 - k).abs.should < 0.2
      end

      it "should be near > if more unexcpected result" do
        @match_1 = FactoryGirl.build(:match, :goals_1 => 1, :goals_2 => 0,
                                     :team_1_odds => 7.0, :team_2_odds => 1.0, :draw_odds => 3.0)
        @match_2 = FactoryGirl.build(:match, :goals_1 => 1, :goals_2 => 0,
                                     :team_1_odds => 6.0, :team_2_odds => 1.0, :draw_odds => 3.0)
        @match_1.send(:odds_k).should > @match_2.send(:odds_k)
      end
    end

    describe "interesting_finish_k" do
      it "should be bigger if lot of goals in second half" do
        FactoryGirl.build(:match, :goals_1 => 10, :half_goals_1 => 0).
          send(:interesting_finish_k).should > 0.8
      end

      it "should be smaller if less goals in second half" do
        FactoryGirl.build(:match, :goals_1 => 0, :half_goals_1 => 0,
                          :goals_2 => 0, :half_goals_2 => 0).
                          send(:interesting_finish_k).should < 0.2
      end
    end

    describe "early goals" do
      it "should be bigger if lot of goals in second half" do
        FactoryGirl.build(:match, :goals_1 => 10, :half_goals_1 => 10).
          send(:early_goals_k).should > 0.8
      end

      it "should be smaller if less goals in second half" do
        FactoryGirl.build(:match, :goals_1 => 10, :half_goals_1 => 0,
                          :goals_2 => 0, :half_goals_2 => 0).
                          send(:early_goals_k).should < 0.2
      end
    end

    describe "leader_change_k" do
      it "should be 0 if no change" do
        FactoryGirl.build(:match).send(:leader_change_k)
        .should == 0
      end

      it "should be 0.5 if minimal change" do
        FactoryGirl.build(:match, :goals_1 => 1)
        .send(:leader_change_k).should == 0.5
      end

      it "should be 1 if leader changed change" do
        FactoryGirl.build(:match, :half_goals_1 => 1,
                          :goals_1 => 1, :goals_2 => 2)
        .send(:leader_change_k).should == 1
      end
    end
  end
end
