class H2hStatsCrawler
  LEAGUE_LIST_URL = "http://www.h2hstats.com/soccer/lgoverview.php"

  def leagues
    result = []

    doc = Nokogiri::HTML(open(LEAGUE_LIST_URL))
    doc.css("table#table1 tbody tr").each do |tr|
      columns = tr.css("td")
      attrs = {}
      attrs[:name] = strip_string columns[0].content
      attrs[:url] = "http://www.h2hstats.com/soccer/" + columns[0].css("a").attr("href").value
      attrs[:code] = attrs[:url].match(/getlg=([A-Z]+)/)[1]

      result << OpenStruct.new(attrs)
    end

    result
  end

  protected

  def strip_string(string)
    string.strip.gsub(/^[[:space:]]+/, "").gsub(/[[:space:]]+$/, "")
  end
end
