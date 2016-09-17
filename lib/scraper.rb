class Scraper

	attr_accessor :cli, :gfs_noko_html, :stock

	def initialize(cli)
		self.cli = cli
	end

	def gfs_url(symbol)
		"https://www.google.com/finance?q=" + symbol
	end

	def load_gfs_noko_html(url)
		self.gfs_noko_html = Nokogiri::HTML(open(url))
	end

	# Returns an array. Array[0] is a stock if one was succesfully created and nil otherwise.
	# Array[1] indicates whether the symbol cooresponds to a mutual fund.
	def load_gfs(symbol, fixture_url = nil)
		fixture_url.nil? ? load_gfs_noko_html(self.gfs_url(symbol)) : load_gfs_noko_html(fixture_url)
		return [nil, true] unless self.gfs_noko_html.text.match('\(MUTF:').nil?
		return [nil, false] if self.gfs_noko_html.css("span.pr").text.strip == "" # checks whether the page lists a price
	#	return [nil, false] if self.gfs_noko_html.css("div.fjfe-content").text.include?("- produced no matches.")
		[self.create_stock(symbol), false]
	end

	def create_stock(symbol)
		data = scrape_stock(symbol)
		Stock.new(data)
	end

	def scrape_stock(symbol)
		data = { stock: {} }
		data[:stock][:symbol] = symbol
		begin
			data[:stock][:name] = self.gfs_noko_html.css("div.g-first a").text.match('(?<=All news for )[\w,.)() ]*(?= »)')[0]
		rescue NoMethodError
			data[:stock][:name] = ""
		end
		data[:stock][:exchange] = self.gfs_noko_html.css("span.dis-large").text.split("\n")[0]
		data[:stock] = self.nil_to_empty_str(data[:stock])
		data[:quote] = self.scrape_quote
		data[:desc] = self.scrape_desc
		data
	end

	def scrape_quote
		data = {}
		data[:price] = self.gfs_noko_html.css("span.pr").text.strip
		data[:change] = self.gfs_noko_html.css("div.nwp span.bld").text.split("\n")[0]
		begin
			data[:change_pct] = self.gfs_noko_html.css("div.nwp span.bld").text.split("\n")[1].gsub(/[)(]/, '')
		rescue NoMethodError
			data[:change_pct] = ""
		end
		data[:range] = self.gfs_noko_html.css("td[data-snapfield='range']+td").text.strip
		data[:range_yr] = self.gfs_noko_html.css("td[data-snapfield='range_52week']+td").text.strip
		data[:open] = self.gfs_noko_html.css("td[data-snapfield='open']+td").text.strip
		data[:volume] = self.gfs_noko_html.css("td[data-snapfield='vol_and_avg']+td").text.strip.split("/")[0]
		data[:volume_avg] = self.gfs_noko_html.css("td[data-snapfield='vol_and_avg']+td").text.strip.split("/")[1]
		data[:mkt_cap] = self.gfs_noko_html.css("td[data-snapfield='market_cap']+td").text.strip
		data[:pe_ttm] = self.gfs_noko_html.css("td[data-snapfield='pe_ratio']+td").text.strip
		data[:div_yld] = self.gfs_noko_html.css("td[data-snapfield='latest_dividend-dividend_yield']+td").text.strip.split("/")[1]
		nil_to_empty_str(data)
	end

	def scrape_desc
		data = {}
		data[:sector] = self.gfs_noko_html.css("a#sector").text
		data[:industry] = self.gfs_noko_html.css("a#sector+a").text
		data[:summary] = self.gfs_noko_html.css("div.companySummary").text.gsub("More from Reuters »", "").strip
		nil_to_empty_str(data)
	end

	# convert any nil values to empty strings to avoid exceptions
	def nil_to_empty_str(data_hash)
		data_hash.each do |key, value|
			data_hash[key] = "" if data_hash[key].nil?
		end
	end

end