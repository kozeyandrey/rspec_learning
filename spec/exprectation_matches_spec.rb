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

  describe 'numeric comparison matches' do
    it 'will match less than/greater than' do
      expect(10).to be > 9
      expect(10).to be >= 10
      expect(10).to be <= 10
      expect(9).to be < 10
    end

    it 'will match numeric ranges' do
      expect(10).to be_between(5, 10).inclusive
      expect(10).not_to be_between(5, 10).exclusive
      expect(10).to be_within(1).of(11)
      expect(5..10).to cover(9)
    end
  end

  describe 'collection matchers' do
    it 'will match arrays' do
      array = [1, 2, 3]

      expect(array).to include(3)
      expect(array).to include(1, 3)

      expect(array).to start_with(1)
      expect(array).to end_with(3)

      # for match_array you specify array, but for contain_exactly you specify individual args
      expect(array).to match_array([2, 1, 3]) # any order
      expect(array).not_to match_array([2, 1])

      expect(array).to contain_exactly(3, 2, 1) # similar to match_array
      expect(array).not_to contain_exactly(2, 1) # but use individual args
    end

    it 'will match strings' do
      string = 'some string'

      expect(string).to include('ring')
      expect(string).to include('so', 'ring')

      expect(string).to start_with('so')
      expect(string).to end_with('ing')
    end

    it 'will match hashed' do
      hash = {a: 1, b: 2, c: 3}

      expect(hash).to include(:a)
      expect(hash).to include(a: 1)

      expect(hash).to include(:a, :c)
      expect(hash).to include(a: 1, c: 3)

      expect(hash).not_to include({'a' => 1, 'c' => 2}) # Symbol != String
    end
  end
end