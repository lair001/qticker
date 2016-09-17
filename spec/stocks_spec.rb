require 'spec_helper'

describe 'Stocks' do
let(:cli){Cli.new}

	describe 'Scraper' do

		describe '#initialize' do
			it 'makes a new Scraper' do
				expect(Scraper.new(cli)).to be_a(Scraper)
			end
		end

		describe '#gfs_url' do
			it 'returns a url string based on a ticker symbol' do
				expect(cli.scraper.gfs_url('IBM')).to be_a(String)
				expect(cli.scraper.gfs_url('IBM')).to eq('https://www.google.com/finance?q=IBM')
			end
		end

		describe '#load_gfs' do 
			it 'returns a stock for a valid symbol and whether the entered symbol is a mutual fund' do 
				expect(cli.scraper.load_gfs('MSFT')).to be_an(Array)
				expect(cli.scraper.load_gfs('MSFT')[0]).to be_a(Stock)
				expect(cli.scraper.load_gfs('MSFT')[1]).to eq(false)
				expect(cli.scraper.load_gfs('FBIOX')[0]).to eq(nil)
				expect(cli.scraper.load_gfs('FBIOX')[1]).to eq(true)
				expect(cli.scraper.load_gfs('a1b2c3d4')[0]).to eq(nil)
				expect(cli.scraper.load_gfs('a1b2c3d4')[1]).to eq(false)
			end
		end

		describe '#create_stock' do 
			it 'returns a hash containing 3 hashes' do 
				cli.scraper.load_gfs('IBM')
				expect(cli.scraper.create_stock('IBM')).to be_a(Hash)
				expect(cli.scraper.create_stock('IBM').length).to eq(3)
				expect(cli.scraper.create_stock('IBM')[:stock]).to be_a(Hash)
				expect(cli.scraper.create_stock('IBM')[:quote]).to be_a(Hash)
				expect(cli.scraper.create_stock('IBM')[:desc]).to be_a(Hash)
			end
		end

	end

end