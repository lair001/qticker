module QuickTicker

	class Stock < QuickTicker::Table

		attr_accessor :quote, :description, :related_companies

		def initialize(data)

			super(data[:stock])
			self.quote = QuickTicker::StockQuote.new(data[:quote], self)
			self.description = QuickTicker::StockDescription.new(data[:description], self)
			self.related_companies = []
			data[:related_companies].each do |related_company_hash|
				self.related_companies << QuickTicker::StockRelatedCompany.new(related_company_hash, self)
			end
		end

	end

end