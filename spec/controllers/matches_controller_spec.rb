require 'spec_helper'

describe MatchesController do
  include Rspec::Support::MatchesHelper

  after(:each) do
    response.status.should == 200
  end

  context "no matches" do
    it "should return empty array" do
      get :index
      assigns(:matches).should be_empty
    end
  end

  context "matches exist" do
    before(:each) do
    end

    it "should asign matches" do
      FactoryGirl.create(:match)
      get :index
      assigns(:matches).should_not be_empty
    end

    it "should sort matches by began_on" do
      @match_1 = FactoryGirl.create(:match, :began_on => 2.day.ago)
      @match_2 = FactoryGirl.create(:match, :began_on => 1.day.ago)
      get :index
      assigns(:matches).map(&:id).should == [@match_2, @match_1].map(&:id)
    end

    it "should sort matches by rating" do
      @match_1 = FactoryGirl.create(:match)
      @match_2 = FactoryGirl.create(:match)
      set_macth_rating(@match_2, @match_2.rating + 1)

      get :index

      assigns(:matches).map(&:id).should == [@match_2, @match_1].map(&:id)
    end

    it "should select only last N matches" do
      MatchesController::LIMIT.times { FactoryGirl.create(:match, :began_on => 10.days.ago) }
      set_all_macthes_rating(10)
      @last_match = FactoryGirl.create(:match, :began_on => 5.days.ago)
      set_macth_rating(@last_match, 5)

      get :index

      assigns(:matches).map(&:id).should include(@last_match.id)
    end
  end
end

