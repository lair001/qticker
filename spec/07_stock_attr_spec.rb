require 'spec_helper.rb'

describe 'StockAttr' do

  let(:stock_data) { {
					stock: {name: "Fic", symbol: "???", exchange: "FCSE"},
					quote: {price: "1.23", vol: "123"},
					desc: {sector: "Fic", description: "A fairy tale"}
				} }
  let(:attr_data) {{symbol: "FIC", name: "Fiction"}}

  let(:stock) {Stock.new(stock_data)}
  let(:stock_attr) {StockAttr.new(attr_data, stock)}

  describe '#initialize' do
    it 'initializes a StockAttr from data that knows about its stock' do
      expect(stock_attr.symbol).to eq("FIC")
      expect(stock_attr.name).to eq("Fiction")
      expect(stock_attr.stock).to eq(stock)
    end
  end

end
