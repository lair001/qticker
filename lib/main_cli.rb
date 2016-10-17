module QuickTicker

	class MainCli < QuickTicker::Cli

		attr_accessor :dev

		def initialize(cli = nil)
			super(cli)
			self.dev = QuickTicker::DevCli.new(self)
		end


		def ticker_symbol_prompt
			valid = false
			while !valid do
				print "\nPlease enter a ticker symbol: "
				symbol = gets.strip.upcase
				if symbol == "DEV"
					self.welcome("Developer Mode", -> {self.dev.option_menu}) if symbol == "DEV"
				else
					valid = self.symbol_validation(symbol, valid)
				end
			end
		end

		def stock_option_menu(opt_1_string, opt_1_lambda)
			input = super(opt_1_string, opt_1_lambda)
			if input == "1"
				opt_1_lambda.()
			elsif input == "2"
				self.ticker_symbol_prompt
			else
				return nil
			end
		end

		def symbol_validation(symbol, valid, fixture_url = nil)
			super(symbol, valid)[0] # returns whether entered symbol was valid
		end

	end

end