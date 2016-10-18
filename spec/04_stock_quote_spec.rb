require 'spec_helper.rb'

describe 'StockQuote' do


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

	let(:stock) {QuickTicker::Stock.new(data)}
	let(:quote) {stock.quote}

	describe '#initialize' do

		it 'initializes a stock description from data' do
			expect(quote).to be_a(QuickTicker::StockQuote)
			expect(quote.price).to eq("123.45")
			expect(quote.change).to eq("1.23")
			expect(quote.change_pct).to eq("1.01")
			expect(quote.open).to eq("122.22")
			expect(quote.volume).to eq("12M")
			expect(quote.volume_avg).to eq("11M")
			expect(quote.mkt_cap).to eq("5B")
			expect(quote.pe_ttm).to eq("15.25")
			expect(quote.div_yld).to eq("2.70")
		end

	end

end
