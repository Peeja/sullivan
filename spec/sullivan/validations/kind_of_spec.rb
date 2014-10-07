require 'sullivan/validations/kind_of'

describe Sullivan::Validations::KindOf do
  let(:validation) { Sullivan::Validations::KindOf.new(String) }

  it 'accepts an object of the given type' do
    error = validation.validate("a string")
    expect(error).to be_nil
  end

  it 'accepts an object of a subtype of the given type' do
    special_string_class = Class.new(String)
    error = validation.validate(special_string_class.new("a string"))
    expect(error).to be_nil
  end

  it 'does not accept an object of an unrelated type' do
    error = validation.validate(1)
    expect(error).to eq("must be a kind of String")
  end
end
