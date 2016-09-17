class Cli

	attr_accessor :scraper, :stock

	def initialize
		self.scraper = Scraper.new(self)
	end

	def welcome
		print "\nWelcome to Stocks.\n"
		self.ticker_symbol_prompt
	end

	def ticker_symbol_prompt
		valid = false
		while !valid do
			print "\nPlease enter a ticker symbol: "
			symbol = gets.strip.upcase
			self.dev_welcome if symbol == "DEV"
			# stock_array[0] is a stock if one was succesfully created and nil otherwise.
			# stock_array[1] indicates whether the symbol cooresponds to a mutual fund.
			stock_array = self.scraper.load_gfs(symbol)
			self.stock = stock_array[0]
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
			puts "Mutual funds are not currently not supported." if stock_array[1]
		end
		self.display_quote
	end

	def display_quote
		self.stock.display
		self.stock.quote.display
		opt_1_lambda = -> { self.display_desc }
		self.option_menu("Display a company description", opt_1_lambda)
	end

	def display_desc
		self.stock.display
		self.stock.desc.display
		opt_1_lambda = -> { self.display_quote }
		self.option_menu("Redisplay your quote", opt_1_lambda)
	end

	def option_menu(opt_1_string, opt_1_lambda)
		gets
		puts "1. #{opt_1_string} for #{self.stock.symbol}."
		puts "2. Enter another ticker symbol."
		puts "Enter other key to exit."
		input = gets.strip.gsub('.', '')
		if input == "1"
			opt_1_lambda.()
		elsif input == "2"
			puts ""
			self.ticker_symbol_prompt
		else
			return nil
		end
	end

	def dev_welcome
		print "\nWelcome to Developer Mode!.\n\n"
	end

	def dev_option_menu
		puts "Please select a fixture to load:"
		puts "1. Load MSFT.html"
		puts "2. Load IBM.html"
		puts "3. Load QQQ.html"
		puts "4. Load FBIOX.html"
		puts "Or enter any other key to return to"
		puts "your regularly scheduled program."
		input = gets.strip.gsub('.', '')
		if input == "1"
		elsif input == "2"
		elsif input == "3"
		elsif input == "4"
		else
			return nil
		end
	end

end
