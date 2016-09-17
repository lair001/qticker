class StockAttr < Table

	attr_accessor :stock

	def initialize(data_hash, stock)
		super(data_hash)
		self.stock = stock
	end

end