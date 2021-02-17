require './enum_meth'
extend Enumerable


describe "#my_each" do
let(:array) {["Mar", "Dany", "Sofia"]}
  it "return each element" do
    expect(array.my_each).to include("Dany")
  end
end