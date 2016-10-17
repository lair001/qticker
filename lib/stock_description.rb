module QuickTicker

	class StockDescription < QuickTicker::StockAttribute

		def display
			print "#{sector} : #{industry}\n\n"
			puts "#{summary}".fit
		end

	end

end