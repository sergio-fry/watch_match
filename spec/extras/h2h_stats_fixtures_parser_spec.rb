require 'spec_helper'

describe H2hStatsFixturesParser do
  before(:each) do
    @league_fixtures_page = File.read(File.join(Rails.root, "spec/sample_files/h2h_league_fixtures.html"))
    @parser = H2hStatsFixturesParser.new @league_fixtures_page
  end

  describe "matches" do
    it "should find all past matches" do
      @parser.matches.should have(5).items
    end

    describe "match" do
      before(:each) do
        @match = @parser.matches.first
      end

      describe "#record" do
        before(:each) do
          @league = FactoryGirl.create(:league)
        end

        it "should be a Match record" do
          @match.record.should be_a(Match)
        end

        it "should be valid (but only with empty league)" do
          Match.destroy_all
          record = @match.record
          record.league = @league
          record.should be_valid
        end
      end

      it "should contain names of teams" do
        @match.team_1_name.should == "Tottenham"
        @match.team_2_name.should == "Arsenal"
      end

      it "should contain goals" do
        @match.goals_1.should == 2
        @match.goals_2.should == 1
      end

      it "should contain 1-st half goals" do
        @match.half_goals_1.should == 1
        @match.half_goals_2.should == 0
      end

      it "should contain odds" do
        @match.team_1_odds.should == 2.2
        @match.team_2_odds.should == 3.65
        @match.draw_odds.should   == 3.65
      end

      describe "date" do
        it "should be correct if this year" do
          Timecop.freeze Time.mktime(2011, 10, 16)
          @match.date.should == Time.mktime(2011, 10, 2)
        end

        it "should take current year" do
          Timecop.freeze Time.mktime(2012, 10, 16)
          @match.date.should == Time.mktime(2012, 10, 2)
        end

        it "should be in the past" do
          Timecop.freeze Time.mktime(2011, 10, 1)

          @match.date.should be_past
        end
      end
    end
  end
end
