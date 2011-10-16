require 'spec_helper'

describe H2hStatsCrawler do
  before(:each) do
    @crawler = H2hStatsCrawler.new
    @leagues_page = File.read(File.join(Rails.root, "spec/sample_files/h2h_leagues.html"))
    FakeWeb.register_uri(:get, "http://www.h2hstats.com/soccer/lgoverview.php", :body => @leagues_page)
  end

  describe "fetching leagues" do
    it "should fetch all leagues" do
      @crawler.leagues.should have(53).items
    end

    context "league columns" do
      before(:each) do
        @league = @crawler.leagues.first
      end

      it "should fetch name" do
        @league.name.should == "English Premier League"
      end

      it "should fetch url" do
        @league.url.should == "http://www.h2hstats.com/soccer/league.php?getlg=EPL"
      end

      it "should fetch code" do
        @league.code.should == "EPL"
      end

      it "should fetch fixtures url" do
        @league.fixtures_url.should == "http://www.h2hstats.com/soccer/lgfixtures.php?lg=EPL"
      end
    end
  end
end
