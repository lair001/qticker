require 'spec_helper.rb'

describe 'DevCli' do

	let(:main_cli){QuickTicker::MainCli.new}
	let(:dev_cli){main_cli.dev}

	describe '#initialize' do 
		it 'initializes a DevCli that knows about its main cli' do 
			new_main = QuickTicker::MainCli.new
			new_dev = QuickTicker::DevCli.new(new_main)
			expect(new_dev).to be_a(QuickTicker::DevCli)
			expect(new_dev.main).to equal(new_main)
		end
	end

	describe "#call_dev_option_menu" do 

		it "calls #display_dev_option_menu and #process_stock_option_menu_input" do
			expect(dev_cli).to receive(:display_dev_option_menu)
			expect(dev_cli).to receive(:process_dev_option_menu_input)
			dev_cli.call_dev_option_menu
		end

	end

	describe '#display_dev_option_menu' do

		it 'displays a list menu and returns the user\'s input' do 
			allow(dev_cli).to receive(:gets).and_return("1")
			return_value = ""
			output = capture_puts{return_value = dev_cli.display_dev_option_menu}
			expect(output).to include("Please select a fixture to load:")
			expect(return_value).to eq("1")
		end

	end

	describe "process_stock_option_menu_input" do

		it 'calls symbol_validation if the input corrects to a valid fixture or displays the exit message otherwise' do
			silence do
				expect(dev_cli).to receive(:symbol_validation)
				dev_cli.process_dev_option_menu_input("1")

				dev_cli.process_dev_option_menu_input("\n")
				output = capture_puts{dev_cli.process_dev_option_menu_input("\n")}
				expect(output).to include(dev_cli.exit_message)

				expect(dev_cli).to receive(:exit_message)
				dev_cli.process_dev_option_menu_input("\n")
			end
		end

	end

	describe "symbol_validation" do 

		it "calls #call_dev_option_menu if the fixture chosen is a mutual fund" do 
			silence do
				expect(dev_cli).to receive(:call_dev_option_menu)
				dev_cli.symbol_validation("FBIOX", "http://lair001.github.io/fixtures/qticker/FBIOX.html")
			end
		end

		it "returns true if the fixture chosen is a stock or ETF" do
			silence do
				expect(dev_cli.symbol_validation("MSFT", "http://lair001.github.io/fixtures/qticker/MSFT.html")).to eq(true)
				expect(dev_cli.symbol_validation("QQQ", "http://lair001.github.io/fixtures/qticker/QQQ.html")).to eq(true)
			end
		end

	end


end