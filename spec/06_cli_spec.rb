require 'spec_helper.rb'

describe Cli do 

	let(:cli){Cli.new}

	describe '#intialize' do
		it 'initializes a cli with a scraper' do
			expect(cli).to be_a(Cli)
			expect(cli.scraper).to be_a(Scraper)
		end
	end


end