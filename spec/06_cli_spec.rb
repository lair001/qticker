require 'spec_helper.rb'

describe 'Cli' do 

	let(:cli){QuickTicker::Cli.new}

	let(:data) { {
				stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
				quote: {
				 	price: "123.45",
					change: "1.23",
					change_pct: "1.01",
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
					},
				related_companies: [
					{
						symbol: "EEE",
						price: "12.00",
						change: "0.50",
						change_pct: "4.17",
						mkt_cap: "75.00B"
					 },
					 {
					 	symbol: "GGG",
					 	price: "18.00",
					 	change: "0.40",
						change_pct: "2.22",
					 	mkt_cap: "55.00B"
					 }
					]
			} }

	it "knows about its stock" do 
		stock = QuickTicker::Stock.new(data)
		cli.stock = stock 
		expect(cli.stock).to eq(stock)
	end

	it "knows about its scraper" do 
		scraper = QuickTicker::Scraper.new(cli)
		cli.scraper = scraper 
		expect(cli.scraper).to eq(scraper)
	end

	it "knows about its last_option_lambda" do 
		last_option_lambda = -> { cli.fetch_stock_related_companies }
		cli.last_option_lambda = last_option_lambda 
		expect(cli.last_option_lambda).to eq(last_option_lambda)
	end

	it "knows about its exit_message" do 
		exit_message = "Thank you for using Quick Ticker!\n"
		cli.exit_message = exit_message 
		expect(cli.exit_message).to eq(exit_message)
	end

	describe '#intialize' do
		it 'initializes a Cli with a Scraper' do
			new_cli = QuickTicker::Cli.new
			expect(new_cli).to be_a(QuickTicker::Cli)
			expect(new_cli.scraper).to be_a(QuickTicker::Scraper)
			expect(new_cli.scraper.cli).to eq(new_cli)
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

	describe "call_stock_option_menu" do

		it 'calls display_stock_option_menu and process_stock_option_menu_input' do
			expect(cli).to receive(:display_stock_option_menu)
			expect(cli).to receive(:process_stock_option_menu_input)
			cli.call_stock_option_menu({ option_1_string: "Display a quote", option_2_string: "Display a company description", option_1_lambda: -> { self.fetch_stock_quote }, option_2_lambda: -> { self.fetch_stock_description }, last_option_lambda: -> {self.last_option_lambda.()} })
		end

	end

	describe '#display_stock_option_menu' do

		it 'displays a list menu and returns the user\'s input' do 
			cli.stock = QuickTicker::Stock.new(data)
			allow(cli).to receive(:gets).and_return("\n", "1")
			return_value = ""
			output = capture_puts{return_value = cli.display_stock_option_menu("Display a company description", "Display related companies")}
			expect(output).to include("1. Display a company description for ???.\n2. Display related companies for ???.")
			expect(return_value).to eq("1")
		end

	end

	describe "process_stock_option_menu_input" do

		it 'calls a lambda or displays an exit message depending on the input' do 
			cli.last_option_lambda = -> { cli.fetch_stock_related_companies }
			cli.exit_message = "Thank you for using Quick Ticker!\n"

			expect(cli).to receive(:fetch_stock_quote)
			cli.process_stock_option_menu_input("1", -> { cli.fetch_stock_quote }, -> { cli.fetch_stock_description }, -> {cli.last_option_lambda.()} )

			expect(cli).to receive(:fetch_stock_description)
			cli.process_stock_option_menu_input("2", -> { cli.fetch_stock_quote }, -> { cli.fetch_stock_description }, -> {cli.last_option_lambda.()} )

			expect(cli).to receive(:fetch_stock_related_companies)
			cli.process_stock_option_menu_input("3", -> { cli.fetch_stock_quote }, -> { cli.fetch_stock_description }, -> {cli.last_option_lambda.()} )

			output = capture_puts{cli.process_stock_option_menu_input("\n", -> { cli.fetch_stock_quote }, -> { cli.fetch_stock_description }, -> {cli.last_option_lambda.()} )}
			expect(output).to include(cli.exit_message)
		end

	end

	describe "#symbol_validation" do 

		it 'returns whether a stock symbol is valid and whether it is a mutual fund' do 
			silence do
				allow(cli).to receive(:gets).and_return("\n", "\n")
				expect(cli.symbol_validation('GE')).to eq([true, false])
				expect(cli.symbol_validation('FBIOX')).to eq([false, true])
				expect(cli.symbol_validation('a1b2c3d4')).to eq([false, false])
			end
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

	describe "#display_stock_related_companies" do 

		it "displays information contained in the related companies of the Cli's stock" do 
			cli.stock = QuickTicker::Stock.new(data)
			output = capture_puts{cli.display_stock_related_companies}
			expect(output).to include("EEE")
			expect(output).to include("12.00")
			expect(output).to include("0.50")
			expect(output).to include("4.17")
			expect(output).to include("75.00B")
			expect(output).to include("GGG")
			expect(output).to include("18.00")
			expect(output).to include("0.40")
			expect(output).to include("2.22")
			expect(output).to include("55.00B")
		end

	end

	describe "fetch_stock_quote" do 

		it "displays the stock header and quote and calls call_stock_option_menu" do
			cli.stock = QuickTicker::Stock.new(data)
			expect(cli).to receive(:display_stock_header)
			expect(cli).to receive(:display_stock_quote)
			expect(cli).to receive(:call_stock_option_menu)
			cli.fetch_stock_quote
		end

	end

	describe "fetch_stock_description" do 

		it "displays the stock header and description and calls call_stock_option_menu" do
			cli.stock = QuickTicker::Stock.new(data)
			expect(cli).to receive(:display_stock_header)
			expect(cli).to receive(:display_stock_description)
			expect(cli).to receive(:call_stock_option_menu)
			cli.fetch_stock_description
		end

	end

	describe "fetch_stock_related_companies" do 

		it "displays the stock header and related_companies and calls call_stock_option_menu" do
			cli.stock = QuickTicker::Stock.new(data)
			expect(cli).to receive(:display_stock_header)
			expect(cli).to receive(:display_stock_related_companies)
			expect(cli).to receive(:call_stock_option_menu)
			cli.fetch_stock_related_companies
		end

	end

end