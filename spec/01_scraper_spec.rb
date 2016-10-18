require 'spec_helper'

cli = QuickTicker::Cli.new
scraper = QuickTicker::Scraper.new(cli)

IBM = scraper.load_gfs_noko_html(scraper.gfs_url("IBM"))

describe 'Scraper' do

	describe '#initialize' do
		it 'makes a new Scraper that knows about its cli' do
			expect(scraper).to be_a(QuickTicker::Scraper)
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
			stock_array = scraper.load_gfs('MSFT')
			expect(stock_array).to be_an(Array)
			expect(stock_array[0]).to be_a(QuickTicker::Stock)
			expect(stock_array[1]).to eq(false)

			stock_array = scraper.load_gfs('FBIOX')
			expect(stock_array[0]).to eq(nil)
			expect(stock_array[1]).to eq(true)

			stock_array = scraper.load_gfs('a1b2c3d4')
			expect(stock_array[0]).to eq(nil)
			expect(stock_array[1]).to eq(false)

			expect(cli.scraper).to receive(:create_stock)
			cli.scraper.load_gfs('MSFT')
		end
	end

	describe '#create_stock' do
		it 'calls #scrape_stock and returns a stock' do
			scraper.gfs_noko_html = IBM
			expect(scraper.create_stock('IBM')).to be_a(QuickTicker::Stock)
			expect(scraper).to receive(:scrape_stock)
			begin
				scraper.create_stock('IBM')
			rescue NoMethodError
			end
		end

	end

	describe '#scrape_stock' do 
		it 'returns a hash containing 3 hashes and an array after calling #scrape_stock_quote, scrape_stock_description and scrape_stock_related_companies' do 
			scraper.gfs_noko_html = IBM
			expect(cli.scraper.scrape_stock('IBM')).to be_a(Hash)
			expect(cli.scraper.scrape_stock('IBM').length).to eq(4)
			expect(cli.scraper.scrape_stock('IBM')[:stock]).to be_a(Hash)
			expect(cli.scraper.scrape_stock('IBM')[:quote]).to be_a(Hash)
			expect(cli.scraper.scrape_stock('IBM')[:description]).to be_a(Hash)
			expect(cli.scraper.scrape_stock('IBM')[:related_companies]).to be_an(Array)
			expect(cli.scraper).to receive(:scrape_stock_quote)
			expect(cli.scraper).to receive(:scrape_stock_description)
			expect(cli.scraper).to receive(:scrape_stock_related_companies)
			cli.scraper.scrape_stock('IBM')
		end
	end

	describe "scrape_stock_quote" do 

		it "returns a hash" do 
			scraper.gfs_noko_html = IBM
			hash = cli.scraper.scrape_stock_quote
			expect(hash).to be_a(Hash)
			hash.each do |key, value|
				expect(value).to be_a(String)
			end
		end

	end

	describe "scrape_stock_description" do 

		it "returns a hash of strings" do 
			scraper.gfs_noko_html = IBM
			hash = cli.scraper.scrape_stock_description
			expect(hash).to be_a(Hash)
			hash.each do |key, value|
				expect(value).to be_a(String)
			end
		end

	end

	describe "scrape_stock_related_companies" do 

		it "returns an array of hashes" do 
			scraper.gfs_noko_html = IBM
			array = cli.scraper.scrape_stock_related_companies
			expect(array).to be_an(Array)
			array.each do |hash|
				expect(hash).to be_a(Hash)
			end
		end

	end

	describe '#nil_to_empty_string' do
		it 'converts nil values in a hash to empty strings' do 
			expect(cli.scraper.nil_to_empty_str({n1: nil, n2: 'sandy', n3: nil, n4: nil, n5: 'bill'})).to eq({n1: '', n2: 'sandy', n3: '', n4: '', n5: 'bill'})
		end
	end

end
