class MatchesController < InheritedResources::Base
  before_filter :load_teams, :only => [:new, :edit]

  private

  def load_teams
    @teams = Team.all
  end
end
