require './enum_meth'

describe Enumerable do
  let(:array) {["Mar", "Dany", "Sofia"]}
  let(:num_array) {[1, 2, 4, 2]}

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

  describe "#my_none?" do
    it "returns true if no element in array has a length of 6" do
      expect(array.my_none? { |word| word.length == 6 }).to eql(true)
    end
    it "does not returns true if any element in given array is greater than 4" do
      expect(array.my_none? { |word| word.length >= 4 }).not_to eql(true)
    end
    it "returns true if no element in array satisfy regex" do
      expect(array.my_none? (/z/) ).to eql(true)
    end
    it "return true if array is not made of Float" do
      expect(array.my_none? (Float) ).to eql(true)
    end
    it "return true if all elements of array are falsy" do
      expect([nil, false].my_none?).to eql(true)
    end
    it "does not return true if atleast one elements of array are not falsy" do
      expect([nil, false, true].my_none?).not_to eql(true)
    end
  end

  ary = [1, 2, 4, 2]
ary.count               #=> 4
ary.count(2)            #=> 2
ary.count{ |x| x%2==0 } #=> 3

  describe "#my_count" do
    it "returns the number of elements in the array" do
      expect(num_array.my_count).to eql(4)
    end
    it "does not return a number different from the number of elements in the array" do
      expect(num_array.my_count).not_to eql(5)
    end
    it "returns the number of elements that match the value passed" do
      expect(num_array.my_count(2)).to eql(2)
    end
    it "does not return wrong number of elements that match the value passed" do
      expect(num_array.my_count(2)).not_to eql(3)
    end
    it "returns all the number of even numbers in the array" do
      expect(num_array.my_count { |x| x%2==0 }).to eql(3)
    end
    it "does not return a wrong number of even numbers in the array" do
      expect(num_array.my_count { |x| x%2==0 }).not_to eql(4)
    end
  end
end

