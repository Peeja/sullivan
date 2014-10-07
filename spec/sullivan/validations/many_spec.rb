require 'sullivan/validations/many'
require 'sullivan/validations/kind_of'
require 'sullivan/validations/hash'

describe Sullivan::Validations::Many do
  def many(validation, **opts)
    Sullivan::Validations::Many.new(validation, **opts)
  end

  def hash(validations)
    Sullivan::Validations::Hash.new(validations)
  end

  let(:kind_of_string) { Sullivan::Validations::KindOf.new(String) }

  it 'accepts an empty array' do
    error = many(kind_of_string).validate([])
    expect(error).to be_nil
  end

  it 'accepts an array of matching elements' do
    error = many(kind_of_string).validate(['a', 'b'])
    expect(error).to be_nil
  end

  it 'does not accept an array including a non-matching element' do
    error = many(kind_of_string).validate(['a', 2])
    expect(error).to eq([nil, 'must be a kind of String'])
  end

  it 'accepts an array of matching hashes' do
    error = many(hash(v: kind_of_string)).validate([{v: 'a'}, {v: 'b'}])
    expect(error).to be_nil
  end

  it 'does not accept an array including a non-matching element' do
    error = many(hash(v: kind_of_string)).validate([{v: 'a'}, {v: 2}])
    expect(error).to eq([nil, {v: 'must be a kind of String'}])
  end

  it 'does not accept a non-enumerable' do
    error = many(hash(v: kind_of_string)).validate('a')
    expect(error).to eq('must be an array')
  end

  context "with size requirements" do
    it 'does not accept an array with too few elements' do
      error = many(kind_of_string, at_least: 1).validate([])
      expect(error).to eq('must contain at least 1 element')
    end

    it 'accepts an array with enough elements' do
      error = many(kind_of_string, at_least: 1).validate(['a'])
      expect(error).to be_nil
    end

    it 'does not accept an array with too many elements' do
      error = many(kind_of_string, at_most: 2).validate(['a', 'b', 'c'])
      expect(error).to eq('must contain at most 2 elements')
    end

    it 'accepts an array with few enough elements' do
      error = many(kind_of_string, at_most: 2).validate(['a', 'b'])
      expect(error).to be_nil
    end
  end
end
