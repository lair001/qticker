require 'spec_helper.rb'

describe 'Desc' do


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
				desc: {
					sector: "Fiction",
					industry: "Literature",
					summary: "A lark"
					}
			} }

	let(:stock) {Stock.new(data)}
	let(:desc) {stock.desc}

	describe '#initialize' do

		it 'initializes a stock description from data' do
			expect(desc).to be_a(Desc)
			expect(desc.sector).to eq("Fiction")
			expect(desc.industry).to eq("Literature")
			expect(desc.summary).to eq("A lark")
		end

	end

	describe '#display' do

		it 'displays a stock description\'s attributes' do
			output = capture_puts{desc.display}
			expect(output).to include("Fiction : Literature")
			expect(output).to include("\nA lark")
		end

	end

end
