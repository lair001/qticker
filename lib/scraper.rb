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
		self.create_stock(symbol)
		true
	end

	def create_stock(symbol)
		data = { stock: {} }
		data[:stock][:symbol] = symbol
		data[:stock][:name] = self.gfs_noko_html.css("div.g-first a").text.match('(?<=All news for ).*(?= »)')[0]
		data[:stock][:exchange] = self.gfs_noko_html.css("span.dis-large").text.split("\n")[0]
		data[:quote] = self.create_quote
		data[:desc] = self.create_desc
		self.stock = Stock.new(data)
	end

	def create_quote
		data = {}
		data[:price] = self.gfs_noko_html.css("span.pr").text.strip
		data[:change] = self.gfs_noko_html.css("div.nwp span.bld").text.split("\n")[0]
		data[:change_pct] = self.gfs_noko_html.css("div.nwp span.bld").text.split("\n")[1].gsub(/[)(]/, '')
		data[:range] = self.gfs_noko_html.css("td[data-snapfield='range']+td").text.strip
		data[:range_yr] = self.gfs_noko_html.css("td[data-snapfield='range_52week']+td").text.strip
		data[:open] = self.gfs_noko_html.css("td[data-snapfield='open']+td").text.strip
		data[:volume] = self.gfs_noko_html.css("td[data-snapfield='vol_and_avg']+td").text.strip.split("/")[0]
		data[:volume_avg] = self.gfs_noko_html.css("td[data-snapfield='vol_and_avg']+td").text.strip.split("/")[1]
		data[:mkt_cap] = self.gfs_noko_html.css("td[data-snapfield='market_cap']+td").text.strip
		data[:pe_ttm] = self.gfs_noko_html.css("td[data-snapfield='pe_ratio']+td").text.strip
		data[:div_yld] = self.gfs_noko_html.css("td[data-snapfield='latest_dividend-dividend_yield']+td").text.strip.split("/")[1] + "%"
		data
	end

	def create_desc
		data = {}
		data[:sector] = self.gfs_noko_html.css("a#sector").text
		data[:industry] = self.gfs_noko_html.css("a#sector+a").text
		data[:summary] = self.gfs_noko_html.css("div.companySummary").text.gsub("More from Reuters »", "").strip
		data
	end

end