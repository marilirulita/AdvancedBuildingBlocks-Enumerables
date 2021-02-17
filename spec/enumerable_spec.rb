require './enum_meth'

describe Enumerable do
  let(:array) {["Mar", "Dany", "Sofia"]}

  describe "#my_each" do
    it "return each element given in the array" do
      expect(array.my_each).to include("Dany")
    end
  
    it "if any block passed in returns an enumerable" do
      expect(array.my_each) == (array.to_enum)
    end
  end
  
  describe "#my_each_with_index" do
    it "if a block is passed in returns the array elements given" do
      expect(array.my_each_with_index {|e, i| i if e == "Dany"}).to eql(["Mar", "Dany", "Sofia"])
    end
  
    it "if any block passed in returns an enumerable" do
      expect(array.my_each_with_index) == (array.to_enum)
    end
  end
  
  describe "#my_select" do
    it "returns an array without element select" do
      expect(array.my_select {|e| e != "Dany"}).to eql(["Mar", "Sofia"])
    end
  
    it "returns an array that does not include specific name" do
      expect(array.my_select {|e| e != "Mar" }).not_to include("Mar")
    end
  end

  # %w[ant bear cat].all? { |word| word.length >= 3 } #=> true

  describe "#my_all?" do
    it "" do
      expect(array.my_all { |word| word.length >= 3 }).to eql(true)
    end
  end
end

