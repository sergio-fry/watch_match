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

    it "should not search matches older than 30 days" do
      @match = FactoryGirl.create(:match, :began_on => 31.days.ago)

      get :index

      assigns(:matches).map(&:id).should_not include(@match.id)
    end
  end
end

