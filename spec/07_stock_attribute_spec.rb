require 'spec_helper.rb'

describe 'StockAttribute' do

  let(:stock_data) { {
					stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
					quote: {price: "1.23", vol: "123"},
					description: {sector: "Fic", description: "A fairy tale"}
				} }
  let(:attribute_data) {{symbol: "FIC", name: "Fiction"}}

  let(:stock) {QuickTicker::Stock.new(stock_data)}
  let(:stock_attribute) {QuickTicker::StockAttribute.new(attribute_data, stock)}

  describe '#initialize' do
    it 'initializes a StockAttr from data that knows about its stock' do
      expect(stock_attribute.symbol).to eq("FIC")
      expect(stock_attribute.name).to eq("Fiction")
      expect(stock_attribute.stock).to eq(stock)
    end
  end

end
