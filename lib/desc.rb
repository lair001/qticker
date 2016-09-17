class Desc < StockAttr

	def display
		print "#{sector} : #{industry}\n\n"
		puts "#{summary}".fit
	end

end