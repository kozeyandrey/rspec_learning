describe 'Expectation Matches' do
  describe 'equivalence matches' do
    it 'will match loose equality with #eq' do
      a = '2 cats'
      b = '2 cats'

      expect(a).to eq(b)
      expect(a).to be == b # synonym for #eq

      c = 17
      d = 17.0

      expect(c).to eq(d) # Different types, but "close enough"
    end

    it 'will match loose equality with #eql' do
      # eql? example: x = 1     expect(x).to eql(1)
      a = '2 cats'
      b = '2 cats'

      expect(a).to eql(b) # just a little stricter

      c = 17
      d = 17.0

      expect(c).not_to eql(d) # not the same, close doesn't count
    end

    it 'will match loose equality with #equal' do
      a = '2 cats'
      b = '2 cats'

      expect(a).not_to equal(b) # same value, but different objects

      c = b

      expect(c).to equal(b) # same object
      expect(c).to be(b) # synonym to #equal
    end
  end
end