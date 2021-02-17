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

  describe "#my_all?" do
    it "returns true if each element in given array is greater than 3" do
      expect(array.my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it "does not returns true if any element in given array is greater than 4" do
      expect(array.my_all? { |word| word.length >= 4 }).not_to eql(true)
    end
    it "returns false if atleast one element in array not satisfy regex" do
      expect(array.my_all? (/y/) ).to eql(false)
    end
    it "does not return true if array is not made of numbers" do
      expect(array.my_all? (Numeric) ).not_to eql(true)
    end
    it "returns false if array contains nil" do
      expect([nil, true, 99].my_all?).to eql(false)
    end
    it "returns true if array is empty" do
      expect([].my_all?).to eql(true)
    end
  end

  %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
%w[ant bear cat].any? { |word| word.length >= 4 } #=> true
%w[ant bear cat].any?(/d/)                        #=> false
[nil, true, 99].any?(Integer)                     #=> true
[nil, true, 99].any?                              #=> true
[].any?                                           #=> false

  describe "#my_any?" do
    it "returns true if any element in given array is greater than 3" do
      expect(array.my_any? { |word| word.length >= 3 }).to eql(true)
    end
    it "does not returns true if no element in given array is greater than 6" do
      expect(array.my_any? { |word| word.length >= 6 }).not_to eql(true)
    end
    it "returns false if no element in array satisfy regex" do
      expect(array.my_any? (/z/) ).to eql(false)
    end
    it "does not return true if array is not made of integers" do
      expect(array.my_any? (Integer) ).not_to eql(true)
    end
    it "does not return false if any element in array is truthy" do
      expect([nil, true, 99].my_any?).not_to eql(false)
    end
    it "returns false if array is empty" do
      expect([].my_any?).to eql(false)
    end
  end
end

