require 'spec_helper.rb'

describe 'MainCli' do 

	let(:main_cli){QuickTicker::MainCli.new}
	let(:dev_cli){main_cli.dev}

	describe '#intialize' do
		it 'initializes a MainCli with a Scraper and a DevCli' do
			expect(main_cli).to be_a(QuickTicker::MainCli)
			expect(main_cli.scraper).to be_a(QuickTicker::Scraper)
			expect(main_cli.dev).to be_a(QuickTicker::DevCli)
		end
	end

	describe "ticker_symbol_prompt" do 

		it "renders a ticker symbol prompt" do 
			expect(main_cli).to receive(:gets)
			allow(main_cli).to receive(:gets).and_return("MSFT")
			output = capture_puts{main_cli.ticker_symbol_prompt}
			expect(output).to include("Please enter a ticker symbol:")
		end

		it "calls #welcome on its Dev Cli if the user enters 'DEV' at the prompt" do 
			silence do
				expect(dev_cli).to receive(:welcome)
				allow(main_cli).to receive(:gets).and_return("DEV", nil)
				begin
					main_cli.ticker_symbol_prompt
				rescue NoMethodError
				end
			end
		end

		it "calls #symbol_validation on itself if the user enters something other than 'DEV'" do 
			silence do
				expect(main_cli).to receive(:symbol_validation)
				allow(main_cli).to receive(:gets).and_return("MSFT", nil)
				begin
					main_cli.ticker_symbol_prompt
				rescue NoMethodError 
				end
			end
		end

	end

	describe "symbol_validation" do 

	end

end