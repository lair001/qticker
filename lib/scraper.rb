class Scraper

	attr_accessor :cli, :gfs_noko_html

	def initialize(cli)
		self.cli = cli
	end

	def gfs_url(symbol)
		"https://www.google.com/finance?q=" + symbol
	end

	def load_gfs(symbol)
		self.gfs_noko_html = Nokogiri::HTML(open(self.gfs_url(symbol)))
		return false if self.gfs_noko_html.css("div.fjfe-content").text.include?("- produced no matches.")





		true
	end

end