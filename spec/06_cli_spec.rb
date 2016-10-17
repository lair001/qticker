require 'spec_helper.rb'

describe 'Cli' do 

	let(:cli){QuickTicker::Cli.new}

	let(:data) { {
				stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
				quote: {
				 	price: "123.45",
					change: "1.23",
					change_pct: "1.01%",
					open: "122.22",
					volume: "12M",
					volume_avg: "11M",
					mkt_cap: "5B",
					pe_ttm: "15.25",
					div_yld: "2.70" },
				description: {
					sector: "Fiction",
					industry: "Literature",
					summary: "A lark"
					}
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

	describe '#display_stock_quote' do

		it "displays information contained in the quote of the Cli's stock" do
			cli.stock = QuickTicker::Stock.new(data)
			output = capture_puts{cli.display_stock_quote}
			expect(output).to include("Current:  123.45 1.23(1.01%)\n")
			expect(output).to include("Open:     122.22\n")
			expect(output).to include("Volume:   12M\n")
			expect(output).to include("Avg Vol:  11M\n")
			expect(output).to include("Mkt Cap:  5B\n")
			expect(output).to include("P/E(ttm): 15.25\n")
			expect(output).to include("Yield:    2.70%")
		end

	end

	describe '#display_stock_description' do

		it "displays information contained in the description of the Cli's stock" do
			cli.stock = QuickTicker::Stock.new(data)
			output = capture_puts{cli.display_stock_description}
			expect(output).to include("Fiction : Literature")
			expect(output).to include("\nA lark")
		end

	end

	# test coverage for #display_quote, #display_desc provided in tests for MainCli and DevCli


end