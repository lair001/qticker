require 'spec_helper.rb'

describe 'StockDescription' do


	let(:data) { {
				stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
				quote: {
				 	price: "123.45",
					change: "1.23",
					change_pct: "1.01%",
					open: "122.22",
					volume: "12M",
					volume_avg: "11M",
					mkt_cap: "5B",
					pe_ttm: "15.25",
					div_yld: "2.70"
					},
				description: {
					sector: "Fiction",
					industry: "Literature",
					summary: "A lark"
					},
				related_companies: [{ symbol: "EEE" }]
			} }

	let(:stock) {QuickTicker::Stock.new(data)}
	let(:description) {stock.description}

	describe '#initialize' do

		it 'initializes a stock description from data' do
			expect(description).to be_a(QuickTicker::StockDescription)
			expect(description.sector).to eq("Fiction")
			expect(description.industry).to eq("Literature")
			expect(description.summary).to eq("A lark")
		end

	end

end
