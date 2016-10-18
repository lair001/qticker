require 'spec_helper.rb'

describe 'Stock' do

	let(:data) { {
					stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
					quote: {price: "1.23", vol: "123"},
					description: {sector: "Fic", summary: "A fairy tale"},
					related_companies: [{ symbol: "EEE" }]
				} }

	describe '#initialize' do
		it 'initializes a stock with a quote and a description' do
			stock = QuickTicker::Stock.new(data)
			expect(stock).to be_a(QuickTicker::Stock)
			expect(stock.quote).to be_a(QuickTicker::StockQuote)
			expect(stock.description).to be_a(QuickTicker::StockDescription)
			expect(stock.name).to eq("Fic")
			expect(stock.symbol).to eq("???")
			expect(stock.exchange).to eq("FCSE")
			expect(stock.quote.price).to eq("1.23")
			expect(stock.quote.vol).to eq("123")
			expect(stock.description.sector).to eq("Fic")
			expect(stock.description.summary).to eq("A fairy tale")
		end
	end

end