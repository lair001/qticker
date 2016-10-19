module QuickTicker

	class DevCli < QuickTicker::Cli

		attr_accessor :main

		def initialize(main_cli)
			super(main_cli)
			self.main = main_cli
			self.last_option_lambda = -> { self.call_dev_option_menu }
			self.exit_message = "Leaving Developer Mode and resuming program."
		end

		def call_dev_option_menu 
			process_dev_option_menu_input(display_dev_option_menu)
		end

		def display_dev_option_menu
			puts "\nPlease select a fixture to load:"
			puts "1. Load MSFT.html"
			puts "2. Load IBM.html"
			puts "3. Load QQQ.html"
			puts "4. Load FBIOX.html"
			puts "Or enter any other key to return to"
			puts "your regularly scheduled program."
			gets.strip.gsub('.', '')
		end

		def process_dev_option_menu_input(input)
			if input == "1"
				valid = self.symbol_validation("MSFT", "http://lair001.github.io/fixtures/qticker/MSFT.html")
			elsif input == "2"
				valid = self.symbol_validation("IBM", "http://lair001.github.io/fixtures/qticker/IBM.html")
			elsif input == "3"
				valid = self.symbol_validation("QQQ", "http://lair001.github.io/fixtures/qticker/QQQ.html")
			elsif input == "4"
				valid = self.symbol_validation("FBIOX", "http://lair001.github.io/fixtures/qticker/FBIOX.html")
			else
				puts "Leaving Developer Mode and resuming program."
			end
			return nil
		end

		def symbol_validation(symbol, fixture_url = nil)
			valid_array = super(symbol, fixture_url)
			if valid_array[1] # whether entered symbol was a mutual fund
				call_dev_option_menu
			end
			valid_array[0] # returns whether entered symbol was valid
		end

	end

end