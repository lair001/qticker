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

	describe '#initialize' do

		it 'initializes a stock description from data' do
			description = QuickTicker::StockDescription.new(data[:description], stock)
			expect(description).to be_a(QuickTicker::StockDescription)
			expect(description.sector).to eq("Fiction")
			expect(description.industry).to eq("Literature")
			expect(description.summary).to eq("A lark")
		end

	end

end
