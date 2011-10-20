class MatchesController < InheritedResources::Base

  private

  def collection
    @matches ||= Match.recent.order("rating desc, began_on desc")
  end
end
