class H2hStatsCrawler
  LEAGUE_LIST_URL = "http://www.h2hstats.com/soccer/lgoverview.php"

  class H2hLeague < OpenStruct
    def url
      "http://www.h2hstats.com/soccer/league.php?getlg=#{code}"
    end

    def fixtures_url
      "http://www.h2hstats.com/soccer/lgfixtures.php?lg=#{code}"
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
      attrs[:code] = columns[0].css("a").attr("href").value.match(/getlg=([A-Z]+)/)[1]

      result << H2hLeague.new(attrs)
    end

    result
  end

  def load_new_matches(league_record)
    h2h_league = H2hLeague.new :code => league_record.code
    parser = H2hStatsParser.new(open(h2h_league.fixtures_url))
    parser.matches.each do |match|
      league_record.matches << match.record
    end
    league_record.save
  end

  protected

  def strip_string(string)
    string.strip.gsub(/^[[:space:]]+/, "").gsub(/[[:space:]]+$/, "")
  end
end
