require 'sullivan/validations/hash'
require 'sullivan/validations/kind_of'

describe Sullivan::Validations::Hash do
  def hash(validations)
    Sullivan::Validations::Hash.new(validations)
  end

  let(:kind_of_string) { Sullivan::Validations::KindOf.new(String) }

  it 'accepts a hash with matching keys' do
    error = hash(a: kind_of_string).validate({a: 'a string'})
    expect(error).to be_nil
  end

  it 'does not accept a hash with non-matching keys' do
    error = hash(a: kind_of_string).validate({a: 1})
    expect(error).to eq({a: 'must be a kind of String'})
  end

  it 'does not accept a hash with extra keys' do
    error = hash({}).validate({a: 'a string'})
    expect(error).to eq({a: 'is unexpected'})
  end

  it 'does not accept a hash with missing keys' do
    error = hash(a: kind_of_string).validate({})
    expect(error).to eq({a: 'must be a kind of String'})
  end

  it 'does not accept a non-hash' do
    error = hash({a: kind_of_string}).validate('a')
    expect(error).to eq('must be a hash')
  end

  it 'nests' do
    error = hash(a: hash(b: kind_of_string)).validate({a: {b: 1}})
    expect(error).to eq({a: {b: 'must be a kind of String'}})
  end
end

describe Sullivan::Validations::StringHash do
  def string_hash(validations)
    Sullivan::Validations::StringHash.new(validations)
  end

  let(:kind_of_string) { Sullivan::Validations::KindOf.new(String) }

  it 'accepts a hash with matching keys' do
    error = string_hash(a: kind_of_string).validate({'a' => 'a string'})
    expect(error).to be_nil
  end

  it 'does not accept a hash with non-matching keys' do
    error = string_hash(a: kind_of_string).validate({'a' => 1})
    expect(error).to eq({'a' => 'must be a kind of String'})
  end

  it 'does not accept a hash with extra keys' do
    error = string_hash({}).validate({'a' => 'a string'})
    expect(error).to eq({'a' => 'is unexpected'})
  end

  it 'does not accept a hash with missing keys' do
    error = string_hash(a: kind_of_string).validate({})
    expect(error).to eq({'a' => 'must be a kind of String'})
  end

  it 'does not accept a non-hash' do
    error = string_hash({'a' => kind_of_string}).validate('a')
    expect(error).to eq('must be a hash')
  end

  it 'nests' do
    error = string_hash(a: string_hash(b: kind_of_string)).validate({'a' => {'b' => 1}})
    expect(error).to eq({'a' => {'b' => 'must be a kind of String'}})
  end
end
