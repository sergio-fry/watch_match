module Rspec
  module Support
    module MatchesHelper
      def set_all_macthes_rating(rating)
        Match.update_all("rating = #{rating}") # skip rating calculation
      end
      def set_macth_rating(match, rating)
        Match.update_all("rating = #{rating}", "id = #{match.id}") # skip rating calculation
      end
    end
  end
end
