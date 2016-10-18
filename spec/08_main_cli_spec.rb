require 'spec_helper.rb'

describe 'MainCli' do 

	let(:cli){QuickTicker::MainCli.new}

	describe '#intialize' do
		it 'initializes a MainCli with a Scraper a DevCli' do
			expect(cli).to be_a(QuickTicker::MainCli)
			expect(cli.scraper).to be_a(QuickTicker::Scraper)
			expect(cli.dev).to be_a(QuickTicker::DevCli)
		end
	end

end