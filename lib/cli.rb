class Cli

	attr_accessor :scraper, :stock

	def initialize
		self.scraper = Scraper.new(self)
	end

	def welcome
		puts "Welcome to Stocks."
		self.ticker_symbol_prompt
	end

	def ticker_symbol_prompt
		valid = false
		while !valid do
			print "Please enter a ticker symbol: "
			symbol = gets.strip
			self.stock = self.scraper.load_gfs(symbol)
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
		end
	end

end
