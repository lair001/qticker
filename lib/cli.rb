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
			if symbol == "DEV"
				self.dev_welcome if symbol == "DEV"
			else
				# stock_array[0] is a stock if one was succesfully created and nil otherwise.
				# stock_array[1] indicates whether the symbol cooresponds to a mutual fund.
				stock_array = self.scraper.load_gfs(symbol)
				self.stock = stock_array[0]
				valid = self.stock.nil? ? false : true
				puts "Invalid ticker symbol." if !valid
				puts "Mutual funds are not currently not supported." if stock_array[1]
			end
		end
		self.display_quote
	end

	def display_quote(dev = false)
		self.stock.display
		self.stock.quote.display
		opt_1_lambda = -> { self.display_desc(dev) }
		self.option_menu("Display a company description", opt_1_lambda, dev)
	end

	def display_desc(dev = false)
		self.stock.display
		self.stock.desc.display
		opt_1_lambda = -> { self.display_quote(dev) }
		self.option_menu("Redisplay your quote", opt_1_lambda, dev)
	end

	def option_menu(opt_1_string, opt_1_lambda, dev = false)
		gets
		puts "1. #{opt_1_string} for #{self.stock.symbol}."
		puts "2. Enter another ticker symbol."
		puts "Enter other key to exit."
		input = gets.strip.gsub('.', '')
		if input == "1"
			opt_1_lambda.()
		elsif input == "2" && !dev
			self.ticker_symbol_prompt
		elsif input == "2" && dev
			self.dev_option_menu
		else
			puts "Leaving Developer Mode and resuming program." if dev
			return nil
		end
	end

	def dev_welcome
		print "\nWelcome to Developer Mode!\n\n"
		self.dev_option_menu
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
			stock_array = self.scraper.load_gfs("MSFT", "./spec/fixtures/MSFT.html")
			self.stock = stock_array[0]
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
			puts "Mutual funds are not currently not supported." if stock_array[1]
			self.display_quote(true) if valid
		elsif input == "2"
			stock_array = self.scraper.load_gfs("IBM", "./spec/fixtures/IBM.html")
			self.stock = stock_array[0]
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
			puts "Mutual funds are not currently not supported." if stock_array[1]
			self.display_quote(true) if valid
		elsif input == "3"
			stock_array = self.scraper.load_gfs("QQQ", "./spec/fixtures/QQQ.html")
			self.stock = stock_array[0]
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
			puts "Mutual funds are not currently not supported." if stock_array[1]
			self.display_quote(true) if valid
		elsif input == "4"
			stock_array = self.scraper.load_gfs("FBIOX", "./spec/fixtures/FBIOX.html")
			self.stock = stock_array[0]
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
			puts "Mutual funds are not currently not supported." if stock_array[1]
			self.display_quote(true) if valid
		else
			puts "Leaving Developer Mode and resuming program."
		end
		return nil
	end

end
