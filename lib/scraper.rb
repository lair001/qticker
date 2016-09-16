class Scraper

	attr_accessor :cli, :gfs_noko_html, :stock

	def initialize(cli)
		self.cli = cli
	end

	def gfs_url(symbol)
		"https://www.google.com/finance?q=" + symbol
	end

	def load_gfs(symbol)
		self.gfs_noko_html = Nokogiri::HTML(open(self.gfs_url(symbol)))
		return false if self.gfs_noko_html.css("div.fjfe-content").text.include?("- produced no matches.")
		self.create_stock
		true
	end

	def create_stock
		name = pry(main)> self.gfs_noko_html.css("div.g-first a").text.match('(?<=All news for ).*(?= »)')[0]
		exchange = self.gfs_noko_html.css("span.dis-large").text.split("\n")[0]
		price = self.gfs_noko_html.css("span.pr").text.strip
		change = self.gfs_noko_html.css("div.nwp span.bld").text.split("\n")[0]
		change_pct = self.gfs_noko_html.css("div.nwp span.bld").text.split("\n")[1].gsub(/[)(]/, '')
		range = self.gfs_noko_html.css("td[data-snapfield='range']+td").text.strip
		range_yr = self.gfs_noko_html.css("td[data-snapfield='range_52week']+td").text.strip
		open = self.gfs_noko_html.css("td[data-snapfield='open']+td").text.strip
		volume = self.gfs_noko_html.css("td[data-snapfield='vol_and_avg']+td").text.strip.split("/")[0]
		volume_avg = self.gfs_noko_html.css("td[data-snapfield='vol_and_avg']+td").text.strip.split("/")[1]
		mkt_cap = self.gfs_noko_html.css("td[data-snapfield='market_cap']+td").text.strip
		pe_ttm = self.gfs_noko_html.css("td[data-snapfield='pe_ratio']+td").text.strip
		div_yld = self.gfs_noko_html.css("td[data-snapfield='latest_dividend-dividend_yield']+td").text.strip.split("/")[1] + "%"
		sector = self.gfs_noko_html.css("a#sector").text
		industry = self.gfs_noko_html.css("a#sector+a").text
		desc = self.gfs_noko_html.css("div.companySummary").text.gsub("More from Reuters »", "").strip

	end

end