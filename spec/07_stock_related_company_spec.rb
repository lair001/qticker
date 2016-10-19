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

	let(:stock) {QuickTicker::Stock.new(data)}

	describe "initialize" do 

		it "initalizes a new stock related company from data" do
			related_company = QuickTicker::StockRelatedCompany.new(data[:related_companies][0], stock)
			expect(related_company).to be_a(QuickTicker::StockRelatedCompany)
			expect(related_company.symbol).to eq("EEE")
			expect(related_company.price).to eq("12.00")
			expect(related_company.change).to eq("0.50")
			expect(related_company.change_pct).to eq("4.17")
			expect(related_company.mkt_cap).to eq("75.00B")

		end

	end

end