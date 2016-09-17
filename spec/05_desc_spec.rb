require 'spec_helper.rb'

describe Desc do 


	let(:data) { {
				 	sector: "Fiction",
					industry: "Literature",
					summary: "A lark"
			} }

	let(:desc) {Desc.new(data)}

	describe '#initialize' do

		it 'initializes a stock description from data' do
			expect(desc).to be_a(Desc)
			expect(desc.sector).to eq("Fiction")
			expect(desc.industry).to eq("Literature")
			expect(desc.summary).to eq("A lark")
		end

	end

	describe '#display' do 

		it 'displays a stock description\'s attributes' do 
			output = capture_puts{desc.display}
			expect(output).to include("Fiction : Literature")
			expect(output).to include("\nA lark")
		end

	end

end