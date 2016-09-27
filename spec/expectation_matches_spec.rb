require 'car'

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

  describe 'other useful matchers' do
    it 'will match string with a regex' do
      # This matcher is a good way to "spot check" strings
      string = 'The order has been received.'

      expect(string).to match(/order(.+)received/) # (.+) - is a space

      expect('123').to match(/\d{3}/)
      expect(123).not_to match(/\d{3}/) # only works with string

      email = 'someone@somewhere.org'
      expect(email).to match(/\A\w+@\w+\.\w{3}\Z/)
    end

    it 'will match object types' do
      expect('test').to be_instance_of(String)
      expect('test').to be_an_instance_of(String) # alias of #be_instance_of

      expect('test').to be_kind_of(String)
      expect('test').to be_a_kind_of(String) # alias of #be_kind_of

      expect('test').to be_a(String) # alias of #be_kind_of
      expect([1, 2, 3]).to be_an(Array) # alias of #be_kind_of
    end

    it 'will match class instances to #have_attributes' do
      car = Car.new

      car.make = 'Dodge'
      car.year = 2008
      car.color = 'red'

      expect(car).to have_attributes(:color => 'red')
      expect(car).to have_attributes(:color => 'red', :year => 2008)
    end

    it 'will match anything with #satisfy' do
      # This is the most flexible matcher
      expect(10).to satisfy do |value|
        (value >= 5) && (value <= 10) && (value % 2 == 0)
      end
    end
  end

  describe 'predicate matchers' do
    it 'will match be_* a custom methods ending in ?' do
      # drops "be_", adds "?" to end, calls method on object
      # Can use these when methods end in "?", require no arguments,
      # and return true/false.

      # with built-in methods
      expect([]).to be_empty  # [].empty?
      expect(1).to be_integer  # 1.integer?
      expect(0).to be_zero  # 0.zero?
      expect(1).to be_nonzero  # 2.nonzero?
      expect(1).to be_odd  # 1.odd?
      expect(2).to be_even  # 2.even?

      # be_nil is actually an example of this too

      # with custom methods
      class Product
        def visible?; true; end
      end

      product = Product.new

      expect(product).to be_visible  # product.visible?
      expect(product.visible?).to be true # exactly the same as this
    end

    it 'will match have_* a custom methods like has_*' do
      # changes "have_" to "has_", adds "?" to end, calls method on object
      # Can use these when methods start with "has_", end in "?"
      # and return true/false. Can have arguments, but not require

      # with built-in methods
      hash = {a: 1, b: 2}
      expect(hash).to have_key(:a) # hash.has_key?
      expect(hash).to have_value(2) # hash.has_value?

      # with custom methods
      class Customer
        def has_pending_order?; true; end
      end

      customer = Customer.new

      expect(customer).to have_pending_order # customer.has_pending_order?
      expect(customer.has_pending_order?).to be true # same as this
    end
  end

  describe 'observation matchers' do
    # Note that all of these use "expect {}", not "expect()".
    # It is a special block format that allows a
    # process to take place inside of the expectation

    it 'will match when events change object attributes' do
      # calls the test before the block,
      # then again after the block
      array = []
      expect { array << 1 }.to change(array, :empty?).from(true).to(false)

      class WebsiteHits
        attr_accessor :count
        def initialize; @count = 0; end
        def increment; @count += 1; end
      end

      hits = WebsiteHits.new

      expect { hits.increment }.to change(hits, :count).from(0).to(1)
    end

    it 'will match when events change any values' do
      # calls the test before the block,
      # then again after the block

      # notice the "{}" after "change",
      # can be used on simple variables
      x = 10
      expect { x += 1 }.to change {x}.from(10).to(11)
      expect { x += 1 }.to change {x}.by(1) # # Specifies == delta of the expected change
      expect { x += 1 }.to change {x}.by_at_least(1) # Specifies a minimum delta of the expected change.
      expect { x += 1 }.to change {x}.by_at_most(1) # Specifies a maximum delta of the expected change.

      # notice the "{}" after "change",
      # can be used on simple variables
      z = 11
      expect { z += 1 }.to change { z % 3 }.from(2).to(0)

      # Must have a value before the block
      # Must change the value inside the block
    end

    it 'will match when errors are raised' do
      # observes any errors raised by the block

      expect { raise StandardError }.to raise_error
      expect { raise StandardError }.to raise_exception

      expect { 1 / 0 }.to raise_error(ZeroDivisionError)
      expect { 1 / 0 }.to raise_error.with_message("divided by 0")
      expect { 1 / 0 }.to raise_error.with_message(/divided/)

      # Note that the negative form does
      # not accept arguments
      expect { 1 / 1 }.not_to raise_error
    end

    it 'will match when output is generated' do
      # observes output sent to $stdout or $stderr

      expect { raise StandardError }.to raise_error
      expect { raise StandardError }.to raise_exception

      expect { print('hello') }.to output.to_stdout
      expect { print('hello') }.to output('hello').to_stdout
      expect { print('hello') }.to output(/ll/).to_stdout

      expect { warn('problem') }.to output(/problem/).to_stderr
    end
  end
end