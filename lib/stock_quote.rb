class StockQuote < StockAttr

	def display
		puts "Current:  #{price} #{change}(#{change_pct})"
		puts "Open:     #{open}"
		puts "Volume:   #{volume}"
		puts "Avg Vol:  #{volume_avg}"
		puts "Mkt Cap:  #{mkt_cap}"
		puts "P/E(ttm): #{pe_ttm}"
		puts "Yield:    #{div_yld}%"
	end

end