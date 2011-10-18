class H2hStatsParser
  class H2hMatch < OpenStruct
    def date
      date_match = super.match(/([[:digit:]]+)\/([[:digit:]]+)/)
      date = Time.mktime(Time.now.year, date_match[2], date_match[1])

      if date.future?
        date = date - 1.year
      end

      date
    end

    def record
      Match.new({ :team_1 => Team.find_or_create_by_name(team_1_name),
        :team_2 => Team.find_or_create_by_name(team_2_name),
        :team_1_odds => team_1_odds,
        :team_2_odds => team_2_odds,
        :draw_odds => draw_odds,
        :goals_1 => goals_1,
        :goals_2 => goals_2,
        :began_on => date})
    end
  end

  def initialize(html)
    @html = html
    @doc = Nokogiri::HTML(@html)
  end

  def matches
    result = []

    @doc.css("table.forumline tr").each do |tr|
      if tr.css("span.gensmall")[1].try(:content) == "Fin"
        columns = tr.css("span.gensmall")
        attrs = {}
        attrs[:team_1_name] = strip_string(columns[2].content)
        attrs[:team_2_name] = strip_string(columns[4].content)
        attrs[:goals_1] = columns[3].css("b").first.content.split("-")[0].to_i
        attrs[:goals_2] = columns[3].css("b").first.content.split("-")[1].to_i
        attrs[:half_goals_1] = columns[3].content.match(/\(([[:digit:]]+)-[[:digit:]]+\)/)[1].to_i
        attrs[:half_goals_2] = columns[3].content.match(/\([[:digit:]]+-([[:digit:]]+)\)/)[1].to_i

        attrs[:team_1_odds] = strip_string(columns[6].content).to_f
        attrs[:team_2_odds] = strip_string(columns[8].content).to_f
        attrs[:draw_odds]   = strip_string(columns[7].content).to_f

        attrs[:date] = strip_string(columns[0].content)

        result << H2hMatch.new(attrs)
      end
    end

    result
  end

  protected

  def strip_string(string)
    string.strip.gsub(/^[[:space:]]+/, "").gsub(/[[:space:]]+$/, "")
  end
end
