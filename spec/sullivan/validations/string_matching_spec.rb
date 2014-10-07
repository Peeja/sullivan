require 'sullivan/validations/string_matching'

describe Sullivan::Validations::StringMatching do
  def string_matching(validation, **opts)
    Sullivan::Validations::StringMatching.new(validation, **opts)
  end

  it "accepts a string which matches" do
    error = string_matching(/please/).validate('Gimme, please.')
    expect(error).to be_nil
  end

  it "does not accept a string which doesn't match" do
    error = string_matching(/please/).validate('Gimme.')
    expect(error).to eq('must be a string matching /please/')
  end

  it "takes a custom message" do
    error = string_matching(/abc/, error: 'must contain the magic word').validate('Gimme.')
    expect(error).to eq('must contain the magic word')
  end
end
