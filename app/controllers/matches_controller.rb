class MatchesController < InheritedResources::Base
  private
  def collection
    @matches ||= Match.order("rating desc")
  end
end
