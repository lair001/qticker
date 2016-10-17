class Stock < QuickTicker::Table

	attr_accessor :quote, :description

	def initialize(data)

		super(data[:stock])
		self.quote = StockQuote.new(data[:quote], self)
		self.description = StockDescription.new(data[:description], self)

	end

	def display
		print "\n#{name} (#{exchange}:#{symbol})\n\n"
	end

end