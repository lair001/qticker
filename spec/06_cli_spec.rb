require 'spec_helper.rb'

describe 'Cli' do 

	let(:cli){QuickTicker::Cli.new}

	let(:data) { {
				stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
				quote: {price: "1.23", vol: "123"},
				description: {sector: "Fic", summary: "A fairy tale"}
			} }

	describe '#intialize' do
		it 'initializes a Cli with a Scraper' do
			expect(cli).to be_a(QuickTicker::Cli)
			expect(cli.scraper).to be_a(QuickTicker::Scraper)
			expect(cli.scraper.cli).to eq(cli)
		end
	end

	describe "#welcome" do 
		it 'welcomes the user and calls a lambda' do 
			mode_name = "Hello World"
			mode_lambda = -> { puts "Hello World!" }
			output = capture_puts{ cli.welcome(mode_name, mode_lambda) }
			expect(output).to include("Welcome to Hello World!\nHello World!\n")
		end
	end

	describe '#stock_option_menu' do 
		it 'displays a list menu and returns the user\'s input' do 
			cli.stock = QuickTicker::Stock.new(data)
			allow(cli).to receive(:gets).and_return("\n", "1")
			output = capture_puts{cli.stock_option_menu("Display a company description") }
			expect(output).to include("1. Display a company description for ???.")
			allow(cli).to receive(:gets).and_return("\n", "1")
			expect(cli.stock_option_menu("Display a company description")).to eq("1")
		end
	end

	describe "#symbol_validation" do 

		it 'returns whether a stock symbol is valid and whether it is a mutual fund' do 
			allow(cli).to receive(:gets).and_return("\n", "\n")
			expect(cli.symbol_validation('GE', false)).to eq([true, false])
			expect(cli.symbol_validation('FBIOX', false)).to eq([false, true])
			expect(cli.symbol_validation('a1b2c3d4', false)).to eq([false, false])
		end

	end

	describe '#display_stock_header' do 

		it "displays a header comprising attributes of the Cli's stock" do 
			cli.stock = QuickTicker::Stock.new(data)
			output = capture_puts{cli.display_stock_header}
			expect(output).to include("Fic (FCSE:???)")
		end

	end

	# test coverage for #display_quote, #display_desc provided in tests for MainCli and DevCli


end