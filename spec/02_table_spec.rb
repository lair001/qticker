require 'spec_helper.rb'

describe 'Table' do 

	describe '#initialize' do
		it 'creates an object whoses attributes are keys in a hash' do 
			table1 = QuickTicker::Table.new(name: "Richard", age: 43, cats: ["Fluffy", "Doodles"])
			table2 = QuickTicker::Table.new(title: "The Inferno", author: "Dante" )
			expect(table1.name).to eq("Richard")
			expect(table1.age).to eq(43)
			expect(table1.cats).to eq(["Fluffy", "Doodles"])
			expect(table2.title).to eq("The Inferno")
			expect(table2.author).to eq("Dante")
			expect(table1.title).to eq(nil)
			expect(table1.author).to eq(nil)
			expect(table2.name).to eq(nil)
			expect(table2.age).to eq(nil)
			expect(table2.cats).to eq(nil)
		end
	end

end