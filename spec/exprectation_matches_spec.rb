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

  # be_truthy was formerly knows as be_true (be_true - don't use this variant)
  # be_falsey was formerly knows as be_false (be_false - don't use this variant)
  describe 'truthiness matches' do
    it 'will match true/false' do
      expect(1 < 2).to be(true) # don't use 'be_true' + passed if expression == true
      expect(1 > 2).to be(false) # don't use 'be_false' + passed if expression == false

      expect('foo').not_to be(true) # this string is not exactly true

      expect(nil).not_to be(false) # nil is not exactly true
      expect(0).not_to be(false) # 0 is not exactly true

    end

    it 'will match truthy/falsey' do
      expect(1 < 2).to be_truthy # passed if expression is truthy (not nil or false)
      expect(1 > 2).to be_falsey # passed if expression is falsey (nil or false)

      expect('foo').to be_truthy # any value counts as true

      expect(nil).to be_falsey # nil counts as false
      expect(0).not_to be_falsey  # but 0 is still not falsey enough
    end

    it 'will match truthy/falsey' do
      expect(nil).to be_nil
      expect(nil).to be(nil) # either way works

      expect(false).not_to be_nil # nil only, just like #nil?

      expect(0).not_to be_nil # nil only, just like #nil?
    end

  end
end