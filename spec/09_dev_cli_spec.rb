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


end