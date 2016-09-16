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
			symbol = gets.strip.upcase
			self.stock = self.scraper.load_gfs(symbol)
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
		end
		self.display_quote
	end

	def display_quote
		self.stock.display
		self.stock.quote.display
		gets
		print "Please enter 1 to display a company description for #{self.stock.symbol}, 2 to enter another ticker symbol or any other key to exit: "
		input = gets.strip
		if input == "1"
			self.display_desc
		elsif input == "2"
			self.ticker_symbol_prompt
		else
			return nil
		end
	end

	def display_desc
		self.stock.display
		self.stock.desc.display
		gets
		print "Please enter 1 to redisplay your quote for #{self.stock.symbol}, 2 to  enter another ticker symbol or any other key to exit: "
		input = gets.strip
		if input == "1"
			self.display_quote
		elsif input == "2"
			self.ticker_symbol_prompt
		else
			return nil
		end
	end

end
