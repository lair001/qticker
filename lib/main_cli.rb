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
					self.dev.welcome("Developer Mode", -> {self.dev.option_menu}) if symbol == "DEV"
				else
					valid = self.symbol_validation(symbol)
				end
			end
		end

		def stock_option_menu(opt_1_string, opt_2_string, opt_1_lambda, opt_2_lambda)
			input = super(opt_1_string, opt_2_string, opt_1_lambda, opt_2_lambda)
			if input == "1"
				opt_1_lambda.()
			elsif input == "2"
				opt_2_lambda.()
			elsif input == "3"
				self.ticker_symbol_prompt
			else
				return nil
			end
		end

		def symbol_validation(symbol, fixture_url = nil)
			super(symbol)[0] # returns whether entered symbol was valid
		end

	end

end