require 'spec_helper.rb'

describe 'Stock' do

	let(:data) { {
					stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
					quote: {price: "1.23", vol: "123"},
					description: {sector: "Fic", summary: "A fairy tale"},
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

	describe '#initialize' do
		it 'initializes a stock with a quote, a description, and an array of related companies' do
			stock = QuickTicker::Stock.new(data)
			expect(stock).to be_a(QuickTicker::Stock)
			expect(stock.quote).to be_a(QuickTicker::StockQuote)
			expect(stock.description).to be_a(QuickTicker::StockDescription)
			expect(stock.related_companies).to be_an(Array)
			expect(stock.related_companies.length).to eq(2)
			expect(stock.related_companies[0]).to be_a(QuickTicker::StockRelatedCompany)
			expect(stock.related_companies[1]).to be_a(QuickTicker::StockRelatedCompany)
			expect(stock.name).to eq("Fic")
			expect(stock.symbol).to eq("???")
			expect(stock.exchange).to eq("FCSE")
			expect(stock.quote.price).to eq("1.23")
			expect(stock.quote.vol).to eq("123")
			expect(stock.description.sector).to eq("Fic")
			expect(stock.description.summary).to eq("A fairy tale")
			expect(stock.related_companies[0].symbol).to eq("EEE")
			expect(stock.related_companies[0].price).to eq("12.00")
			expect(stock.related_companies[0].change).to eq("0.50")
			expect(stock.related_companies[0].change_pct).to eq("4.17")
			expect(stock.related_companies[0].mkt_cap).to eq("75.00B")
		end
	end

end