require 'spec_helper.rb'

describe Quote do


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
					div_yld: "2.70" },
				desc: {sector: "Fic", description: "A fairy tale"}
			} }

	let(:stock) {Stock.new(data)}
	let(:quote) {stock.quote}

	describe '#initialize' do

		it 'initializes a stock description from data' do
			expect(quote).to be_a(Quote)
			expect(quote.price).to eq("123.45")
			expect(quote.change).to eq("1.23")
			expect(quote.change_pct).to eq("1.01%")
			expect(quote.open).to eq("122.22")
		end

	end

	describe '#display' do

		it 'displays a stock description\'s attributes' do
			output = capture_puts{quote.display}
			expect(output).to include("Current:  123.45 1.23(1.01%)\n")
			expect(output).to include("Open:     122.22\n")
			expect(output).to include("Volume:   12M\n")
			expect(output).to include("Avg Vol:  11M\n")
			expect(output).to include("Mkt Cap:  5B\n")
			expect(output).to include("P/E(ttm): 15.25\n")
			expect(output).to include("Yield:    2.70%")
		end

	end

end
