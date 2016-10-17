require 'spec_helper.rb'

describe 'DevCli' do

	let(:main_cli){QuickTicker::MainCli.new}
	let(:cli){main_cli.dev}

	describe '#initialize' do 
		it 'initializes a DevCli that knows about its main cli' do 
			main = QuickTicker::MainCli.new
			dev = QuickTicker::DevCli.new(main)
			expect(dev).to be_a(QuickTicker::DevCli)
			expect(dev.main).to equal(main)
		end
	end

	describe '#option_menu, #stock_option_menu, #symbol_validation' do
		it 'allows the user to load html files in spec/fixtures if the user inputs DEV at the ticker symbol prompt' do
			# allow(main_cli).to receive(:gets).and_return("DEV", "3", "\n", "1", "\n", "\n", "IBM", "\n", "\n")
			allow(main_cli).to receive(:gets).and_return("DEV", "IBM", "\n", "\n")
			allow(cli).to receive(:gets).and_return("3", "\n", "1", "\n", "\n")
			output = capture_puts{cli.welcome("Quick Ticker", -> {main_cli.ticker_symbol_prompt})}
			expect(output).to include("Welcome to Developer Mode!\n\nPlease select a fixture to load:")
			expect(output).to include("Leaving Developer Mode and resuming program.")
			expect(output).to include("PowerShares QQQ Trust, Series 1 (ETF) (NASDAQ:QQQ)")
			expect(output).to include("Open:     115.89")
			expect(output).to include("Financials : Investment Trusts")
			expect(output).to include("objective is to provide investment results that generally")
		end
	end


end