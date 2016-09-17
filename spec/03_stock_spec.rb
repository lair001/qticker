require 'spec_helper.rb'

describe 'Stock' do

	let(:data) { {
					stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
					quote: {price: "1.23", vol: "123"},
					desc: {sector: "Fic", description: "A fairy tale"}
				} }

	describe '#initialize' do
		it 'initializes a stock with a quote and a description' do
			stock = Stock.new(data)
			expect(stock).to be_a(Stock)
			expect(stock.quote).to be_a(Quote)
			expect(stock.desc).to be_a(Desc)
			expect(stock.name).to eq("Fic")
			expect(stock.symbol).to eq("???")
			expect(stock.exchange).to eq("FCSE")
			expect(stock.quote.price).to eq("1.23")
			expect(stock.quote.vol).to eq("123")
			expect(stock.desc.sector).to eq("Fic")
			expect(stock.desc.description).to eq("A fairy tale")
		end
	end

	describe '#display' do 
		it 'displays a stock\'s attributes' do 
			stock = Stock.new(data)
			output = capture_puts{stock.display}
			expect(output).to include("Fic (FCSE:???)")
		end
	end

end