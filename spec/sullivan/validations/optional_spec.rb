require 'sullivan/validations/optional'

describe Sullivan::Validations::Optional do
  def optional(validation)
    Sullivan::Validations::Optional.new(validation)
  end

  def hash(validations)
    Sullivan::Validations::Hash.new(validations)
  end

  let(:kind_of_string) { Sullivan::Validations::KindOf.new(String) }

  it 'should accept a missing value' do
    error = optional(kind_of_string).validate(nil)
    expect(error).to be_nil
  end

  it 'should accept a present, matching value' do
    error = optional(kind_of_string).validate('foo')
    expect(error).to be_nil
  end

  it 'should reject a present, non-matching value' do
    error = optional(kind_of_string).validate(123)
    expect(error).to eq('must be a kind of String, if present')
  end

  it "doesn't try to add 'if present' to structured errors" do
    error = optional(hash(a: kind_of_string)).validate(a: 123)
    expect(error).to eq(a: 'must be a kind of String')
  end
end
