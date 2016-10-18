module QuickTicker

	class MainCli < QuickTicker::Cli

		attr_accessor :dev

		def initialize(cli = nil)
			super(cli)
			self.dev = QuickTicker::DevCli.new(self)
			self.last_option_lambda = -> { self.ticker_symbol_prompt }
			self.exit_message = "Thank you for using Quick Ticker!\n"
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

		def symbol_validation(symbol, fixture_url = nil)
			super(symbol)[0] # returns whether entered symbol was valid
		end

	end

end