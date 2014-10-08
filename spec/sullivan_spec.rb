require 'sullivan'

describe Sullivan do
  describe ".validation" do
    it "provides a convenient way to access the built-in validations" do
      v = Sullivan.validation do
        hash(
          string_matching: string_matching(/\Al(ol)+\z/, error: "must be be a laugh"),
          kind_of: kind_of(Numeric)
        )
      end

      error = v.validate({})

      expect(error[:string_matching]).to eq("must be be a laugh")
      expect(error[:kind_of]).to eq("must be a kind of Numeric")
    end

    it "uses a non-instance-eval version when the block has an arity of 1" do
      v = Sullivan.validation do |vals|
        expect(a_method_on_self).to eq("can be called without an error")

        vals.hash(
          string_matching: vals.string_matching(/\Al(ol)+\z/, error: "must be be a laugh"),
          kind_of: vals.kind_of(Numeric)
        )
      end

      error = v.validate({})

      expect(error[:string_matching]).to eq("must be be a laugh")
      expect(error[:kind_of]).to eq("must be a kind of Numeric")
    end

    def a_method_on_self
      "can be called without an error"
    end
  end
end
