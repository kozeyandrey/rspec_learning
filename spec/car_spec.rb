require 'car'

describe 'Car' do
	describe 'attributes' do
		it 'allows reading and writing for :make' do
      pending('Debugging a problem') # Pending uses for temporary describing why this test doesn't work, and skip just exit from current test
			car = Car.new
			car.make = 'Test'
			expect(car.make).to eq('Tes')
		end

		it 'allows reading and writing for :year' do
			car = Car.new
			car.year = 9999
			expect(car.year).to eq(9999)
		end

		it 'allows reading and writing for :color' do
			car = Car.new
			car.color = 'Red'
			expect(car.color).to eq('Red')
		end		

		it 'allows reading for :wheels' do
			car = Car.new
			expect(car.wheels).to eq(4)
    end

    it 'allows writing for :doors'
	end

	describe '.colors' do 
		it 'returns an array of color names' do
			c = ['blue', 'black', 'red', 'green']
			expect(Car.colors).to match_array(c) 
		end
	end

	describe '#full_name' do 
		it 'returns a string in the expected format' do
			@honda = Car.new make: 'Honda', year: 2007, color: 'blue'
			expect(@honda.full_name).to eq('2007 Honda (blue)')
		end

		context 'when initialized with no arguments' do 
			it 'returns a string using default values' do
				car = Car.new
				expect(car.full_name).to eq('2007 Volvo (unknown)')
			end
		end
	end
end