module QuickTicker

	class Table

		def initialize(data_hash)

			self.class.create_table_columns(data_hash)
			self.populate_table_columns(data_hash)

		end

		def populate_table_columns(data_hash)
			data_hash.each do |key, value|
				self.send("#{key}=", value)
			end
		end

		def self.create_table_columns(data_hash)
			data_hash.each do |key, value|
				attr_accessor key.to_sym
			end
		end

	end

end