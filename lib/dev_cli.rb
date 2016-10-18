module QuickTicker

	class DevCli < QuickTicker::Cli

		attr_accessor :main

		def initialize(main_cli)
			super(main_cli)
			self.main = main_cli
		end

		def option_menu
			puts "\nPlease select a fixture to load:"
			puts "1. Load MSFT.html"
			puts "2. Load IBM.html"
			puts "3. Load QQQ.html"
			puts "4. Load FBIOX.html"
			puts "Or enter any other key to return to"
			puts "your regularly scheduled program."
			input = gets.strip.gsub('.', '')
			if input == "1"
				valid = self.symbol_validation("MSFT", false, "http://lair001.github.io/fixtures/qticker/MSFT.html")
			elsif input == "2"
				valid = self.symbol_validation("IBM", false, "http://lair001.github.io/fixtures/qticker/IBM.html")
			elsif input == "3"
				valid = self.symbol_validation("QQQ", false, "http://lair001.github.io/fixtures/qticker/QQQ.html")
			elsif input == "4"
				valid = self.symbol_validation("FBIOX", false, "http://lair001.github.io/fixtures/qticker/FBIOX.html")
			else
				puts "Leaving Developer Mode and resuming program."
			end
			return nil
		end

		def stock_option_menu(opt_1_string, opt_2_string, opt_1_lambda, opt_2_lambda)
			input = super(opt_1_string, opt_2_string, opt_1_lambda, opt_2_lambda)
			if input == "1"
				opt_1_lambda.()
			elsif input == "2"
				opt_2_lambda.()
			elsif input == "3"
				self.option_menu
			else
				puts "Leaving Developer Mode and resuming program."
				return nil
			end
		end

		def symbol_validation(symbol, valid, fixture_url = nil)
			valid_array = super(symbol, valid, fixture_url)
			if valid_array[1] # whether entered symbol was a mutual fund
				puts ""
				option_menu
			end
			valid_array[0] # returns whether entered symbol was valid
		end

	end

end