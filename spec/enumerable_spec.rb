require './enum_meth'
extend Enumerable


describe "#my_each" do
let(:array) {["Mar", "Dany", "Sofia"]}
  it "return each element given in the array" do
    expect(array.my_each).to include("Dany")
  end

  it "if any block passed in returns an enumerable" do
    expect(array.my_each) == (array.to_enum)
  end
end

describe "#my_each_with_index" do
let(:array) {["Mar", "Dany", "Sofia"]}
  it "if a block is passed in returns the array elements given" do
    expect(array.my_each_with_index {|e, i| i if e == "Dany"}).to eql(["Mar", "Dany", "Sofia"])
  end

  it "if any block passed in returns an enumerable" do
    expect(array.my_each_with_index) == (array.to_enum)
  end
end