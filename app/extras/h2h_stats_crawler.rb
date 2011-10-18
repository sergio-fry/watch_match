class H2hStatsCrawler
  LEAGUE_LIST_URL = "http://www.h2hstats.com/soccer/lgoverview.php"

  class H2hLeague < OpenStruct
    def url
      "http://www.h2hstats.com/soccer/league.php?getlg=#{code}"
    end

    def fixtures_url(page=1)
      case page
      when 1
        "http://www.h2hstats.com/soccer/lgfixtures.php?lg=#{code}"
      else
        "http://www.h2hstats.com/soccer/lgfixtures.php?lg=#{code}&cp=#{page}"
      end
    end

    def record
      @league ||= League.find_by_code(code)
      @league ||= League.create(:code => code, :name => name)
    end
  end

  def leagues
    result = []

    doc = Nokogiri::HTML(open(LEAGUE_LIST_URL))
    doc.css("table#table1 tbody tr").each do |tr|
      columns = tr.css("td")
      attrs = {}
      attrs[:name] = strip_string columns[0].content
      attrs[:code] = columns[0].css("a").attr("href").value.match(/getlg=([A-Z0-9]+)/)[1]

      result << H2hLeague.new(attrs)
    end

    result
  end

  def load_leagues
    leagues.each(&:record)
  end

  def load_new_matches(league_record, page=1)
    matches_count = league_record.matches.count

    h2h_league = H2hLeague.new :code => league_record.code
    parser = H2hStatsFixturesParser.new(open(h2h_league.fixtures_url(page)))
    parser.matches.each do |match|
      league_record.matches << match.record
    end

    league_record.save

    if league_record.matches.count > matches_count
      load_fixtures_page(league_record, page + 1)
    end
  end
  alias :load_fixtures_page :load_new_matches

  protected

  def strip_string(string)
    string.strip.gsub(/^[[:space:]]+/, "").gsub(/[[:space:]]+$/, "")
  end
end
