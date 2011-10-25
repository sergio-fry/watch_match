class MatchesController < InheritedResources::Base

  private

  def collection
    @matches ||= Match.recent.order("rating desc, began_on desc").includes(:team_1, :team_2, :league)
  end
end
