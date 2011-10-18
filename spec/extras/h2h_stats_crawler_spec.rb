require 'spec_helper'

describe H2hStatsCrawler do
  before(:each) do
    @crawler = H2hStatsCrawler.new
    @leagues_page = File.read(File.join(Rails.root, "spec/sample_files/h2h_leagues.html"))
    FakeWeb.register_uri(:get, "http://www.h2hstats.com/soccer/lgoverview.php", :body => @leagues_page)
  end

  describe "#load_new_matches" do
    before(:each) do
      @league = @crawler.leagues.first.record

      @league_fixtures_page = File.read(File.join(Rails.root, "spec/sample_files/h2h_league_fixtures.html"))
      @league_fixtures_empty_page = File.read(File.join(Rails.root, "spec/sample_files/h2h_league_fixtures_empty.html"))
      FakeWeb.register_uri(:get, "http://www.h2hstats.com/soccer/lgfixtures.php?lg=EPL", :body => @league_fixtures_page)
      FakeWeb.register_uri(:get, "http://www.h2hstats.com/soccer/lgfixtures.php?lg=EPL&cp=2", :body => @league_fixtures_empty_page)
    end

    after(:each) do
      @league.destroy
    end

    it "should load matches to league" do
      @crawler.load_new_matches(@league)
      @league.matches.should have(5).items
    end

    it "should load next page if some new matches found" do
      @crawler.should_receive(:load_fixtures_page).with(@league, 2)
      @crawler.load_new_matches(@league)
    end
  end

  describe "fetching leagues" do
    it "should fetch all leagues" do
      @crawler.leagues.should have(53).items
    end

    describe "#load_leagues" do
      it "should save all leagues" do
        @crawler.load_leagues
        League.count.should == 53
      end

      it "should load missing leagues" do
        @crawler.load_leagues
        League.first.destroy
        @crawler.load_leagues
        League.count.should == 53
      end
    end

    describe "H2hLeague" do
      before(:each) do
        @league = @crawler.leagues.first
      end

      describe "#league" do
        it "should return league record" do
          @league.record.should be_a(League)
        end

        it "should be saved" do
          @league.record.should_not be_new_record
        end

        it "should not create leages twice" do
          2.times{ @crawler.leagues.first.record }
          League.count.should == 1
        end
      end

      it "should fetch name" do
        @league.name.should == "English Premier League"
      end

      it "should fetch code" do
        @league.code.should == "EPL"
      end
    end
  end
end
