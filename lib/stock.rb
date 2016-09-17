class Stock < Table

	attr_accessor :quote, :desc

	def initialize(data)

		super(data[:stock])
		self.quote = Quote.new(data[:quote], self)
		self.desc = Desc.new(data[:desc], self)

	end

	def display
		print "\n#{name} (#{exchange}:#{symbol})\n\n"
	end

end