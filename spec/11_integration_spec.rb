require 'spec_helper.rb'

describe "Integration Tests" do 

	let(:main_cli){QuickTicker::MainCli.new}
	let(:dev_cli){main_cli.dev}

	describe 'Example 1' do 
		it 'welcomes the user and allows the user to enter a stock symbol and view information on the company.' do 
			allow(main_cli).to receive(:gets).and_return("IBM", "\n", "1", "\n", "2", "\n", "\n")
			output = capture_puts{main_cli.welcome("Quick Ticker", -> {main_cli.ticker_symbol_prompt})}
			expect(output).to include("Welcome to Quick Ticker!\n\nPlease enter a ticker symbol:")
			expect(output).to include("International Business Machines Corp. (NYSE:IBM)\n\nCurrent:")
			expect(output).to include("International Business Machines Corp. (NYSE:IBM)\n\nTechnology : Technology Consulting & Outsourcing Services")
			expect(output).to include("International Business Machines Corp. (NYSE:IBM)\n\nSymbol  Price                   Mkt Cap")
			expect(output).to include("1. Display a company description for IBM.")
			expect(output).to include("1. Display a quote for IBM.")
			expect(output).to include("2. Display related companies for IBM.")
			expect(output).to include("3. Enter another ticker symbol.\nEnter any other key to exit.")
		end
	end

	describe 'Example 2' do 
		it 'prompts the user to input another ticker symbol if the user inputs an invalid symbol or a symbol for a mutual fund' do 
			allow(main_cli).to receive(:gets).and_return("a1b2c3d4", "FBIOX", "IBM", "\n", "1", "\n", "\n")
			output = capture_puts{main_cli.welcome("Quick Ticker", -> {main_cli.ticker_symbol_prompt})}
			expect(output).to include("Invalid ticker symbol.\n\nPlease enter a ticker symbol:")
			expect(output).to include("Invalid ticker symbol.\nMutual funds are not currently not supported.\n\nPlease enter a ticker symbol:")
		end
	end

	describe 'Example 3' do
		it 'allows the user to load html files in spec/fixtures if the user inputs DEV at the ticker symbol prompt' do
			# allow(main_cli).to receive(:gets).and_return("DEV", "3", "\n", "1", "\n", "\n", "IBM", "\n", "\n")
			allow(main_cli).to receive(:gets).and_return("DEV", "IBM", "\n", "\n")
			allow(dev_cli).to receive(:gets).and_return("3", "\n", "1", "\n", "\n")
			output = capture_puts{main_cli.welcome("Quick Ticker", -> {main_cli.ticker_symbol_prompt})}
			expect(output).to include("Welcome to Developer Mode!\n\nPlease select a fixture to load:")
			expect(output).to include("Leaving Developer Mode and resuming program.")
			expect(output).to include("PowerShares QQQ Trust, Series 1 (ETF) (NASDAQ:QQQ)")
			expect(output).to include("Open:     117.10")
			expect(output).to include("Financials : Investment Trusts")
			expect(output).to include("objective is to provide investment results that generally")
		end
	end

end