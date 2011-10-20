class MatchesController < InheritedResources::Base
  LIMIT = 20

  private

  def collection
    @matches ||=
      begin
        ids = Match.select("id").order("began_on desc").limit(LIMIT).
          map(&:id)
        Match.where(:id => ids).order("rating desc, began_on desc")
      end
  end
end
