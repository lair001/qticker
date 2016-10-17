module QuickTicker

	class Stock < QuickTicker::Table

		attr_accessor :quote, :description

		def initialize(data)

			super(data[:stock])
			self.quote = QuickTicker::StockQuote.new(data[:quote], self)
			self.description = QuickTicker::StockDescription.new(data[:description], self)

		end

	end

end