require 'spec_helper.rb'

describe 'MainCli' do 

	let(:main_cli){QuickTicker::MainCli.new}
	let(:dev_cli){main_cli.dev}

	it "knows about its DevCli" do 
		new_dev_cli = QuickTicker::DevCli.new(main_cli)
		main_cli.dev = new_dev_cli
		expect(main_cli.dev).to eq(new_dev_cli)
	end

	describe '#intialize' do
		it 'initializes a MainCli with a Scraper and a DevCli' do
			new_main_cli = QuickTicker::MainCli.new
			expect(new_main_cli).to be_a(QuickTicker::MainCli)
			expect(new_main_cli.scraper).to be_a(QuickTicker::Scraper)
			expect(new_main_cli.dev).to be_a(QuickTicker::DevCli)
			expect(new_main_cli.scraper.cli).to eq(new_main_cli)
			expect(new_main_cli.dev.main).to eq(new_main_cli)
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

		it "returns whether a ticker symbol is valid" do 
			silence do
				expect(main_cli.symbol_validation("MSFT")).to eq(true)
				expect(main_cli.symbol_validation("abcd1234")).to eq(false)
			end
		end

	end

end