class Cli

	attr_accessor :symbol, :scraper

	def initialize
		self.scraper = Scraper.new
	end

	def welcome
		puts "Welcome to Stocks."
	end

	def ticker_symbol_prompt
		valid = false
		while !valid do
			print "Please enter a ticker symbol: "
			self.symbol = gets.strip
			valid = self.scraper.load_gf
		end
	end

end
