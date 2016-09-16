class Stock < Table

	attr_accessor :quote, :desc

	def initialize(data)

		super(data[:stock])
		self.quote = Quote.new(data[:quote])
		self.desc = Desc.new(data[:desc])

	end

	def display_stock_header
		puts "#{name} (#{exchange}:#{symbol})"
	end

end