module QuickTicker

	class Cli

		attr_accessor :stock, :scraper

		def initialize(cli = nil)
			self.scraper = QuickTicker::Scraper.new(self)
		end

		def welcome(mode_name, mode_lambda)
			print "\nWelcome to " + mode_name + "!\n"
			mode_lambda.()
		end

		def display_stock_header
			print "\n#{self.stock.name} (#{self.stock.exchange}:#{self.stock.symbol})\n\n"
		end

		def display_stock_quote
			puts "Current:  #{self.stock.quote.price} #{stock.quote.change}(#{stock.quote.change_pct})"
			puts "Open:     #{self.stock.quote.open}"
			puts "Volume:   #{self.stock.quote.volume}"
			puts "Avg Vol:  #{self.stock.quote.volume_avg}"
			puts "Mkt Cap:  #{self.stock.quote.mkt_cap}"
			puts "P/E(ttm): #{self.stock.quote.pe_ttm}"
			puts "Yield:    #{self.stock.quote.div_yld}%"
		end

		def display_stock_description
			print "#{self.stock.description.sector} : #{self.stock.description.industry}\n\n"
			puts "#{self.stock.description.summary}".fit
		end

		def fetch_stock_quote
			self.display_stock_header
			self.display_stock_quote
			self.stock_option_menu("Display a company description", -> { self.fetch_stock_description })
		end

		def fetch_stock_description
			self.display_stock_header
			self.display_stock_description
			self.stock_option_menu("Redisplay your quote", -> { self.fetch_stock_quote })
		end

		def stock_option_menu(opt_1_string, opt_1_lambda = nil)
			gets
			puts "1. #{opt_1_string} for #{self.stock.symbol}."
			puts "2. Enter another ticker symbol."
			puts "Enter any other key to exit."
			gets.strip.gsub('.', '')
		end

		def symbol_validation(symbol, valid, fixture_url = nil)
			# stock_array[0] is a stock if one was succesfully created and nil otherwise.
			# stock_array[1] indicates whether the symbol cooresponds to a mutual fund.
			stock_array = self.scraper.load_gfs(symbol, fixture_url)
			self.stock = stock_array[0]
			valid = self.stock.nil? ? false : true
			puts "Invalid ticker symbol." if !valid
			puts "Mutual funds are not currently not supported." if stock_array[1]
			self.fetch_stock_quote if valid
			# returns an array.
			# array[0] - whether the entered symbol was valid
			# array[1] = stock_array[1] - whether the entered
			# symbol was a mutal fund.
			[valid, stock_array[1]]
		end

	end

end