require 'spec_helper'

describe 'Scraper' do

	let(:cli){Cli.new}
	let(:scraper){Scraper.new(cli)}

	describe '#initialize' do
		it 'makes a new Scraper that knows about its cli' do
			expect(scraper).to be_a(Scraper)
			expect(scraper.cli).to eq(cli)
		end
	end

	describe '#gfs_url' do
		it 'returns a url string based on a ticker symbol' do
			expect(cli.scraper.gfs_url('IBM')).to be_a(String)
			expect(cli.scraper.gfs_url('IBM')).to eq('https://www.google.com/finance?q=IBM')
		end
	end

	describe '#load_gfs_noko_html' do 
		it 'populates a scraper\'s gfs_noko_html attribute given a url' do 
			cli.scraper.load_gfs_noko_html('https://www.google.com/finance?q=IBM')
			expect(cli.scraper.gfs_noko_html).to be_a(Nokogiri::HTML::Document)
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
		it 'returns a stock' do
			cli.scraper.load_gfs('GE')
			expect(cli.scraper.create_stock('GE')).to be_a(Stock)
		end
	end

	describe '#scrape_stock' do 
		it 'returns a hash containing 3 hashes' do 
			cli.scraper.load_gfs('IBM')
			expect(cli.scraper.scrape_stock('IBM')).to be_a(Hash)
			expect(cli.scraper.scrape_stock('IBM').length).to eq(3)
			expect(cli.scraper.scrape_stock('IBM')[:stock]).to be_a(Hash)
			expect(cli.scraper.scrape_stock('IBM')[:quote]).to be_a(Hash)
			expect(cli.scraper.scrape_stock('IBM')[:description]).to be_a(Hash)
		end
	end

	describe '#nil_to_empty_string' do
		it 'converts nil values in a hash to empty strings' do 
			expect(cli.scraper.nil_to_empty_str({n1: nil, n2: 'sandy', n3: nil, n4: nil, n5: 'bill'})).to eq({n1: '', n2: 'sandy', n3: '', n4: '', n5: 'bill'})
		end
	end

end
