module Enumerable
  #Remember yield and the call method.

  #my_each, a method that is identical to #each but (obviously) does not use #each. You'll need to remember the yield statement. Make sure it returns the same thing as #each as well.
  def my_each

  end

  #my_each_with_index in the same way.
  def my_each_with_index

  end

  #my_select in the same way, though you may use #my_each in your definition (but not #each).


  #my_all? (continue as above)


  #my_any?


  #my_none?


  #my_count


  #my_map


  #my_inject


  #Test my_inject by creating a method called #multiply_els which multiplies all the elements of the array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40


  #Modify my_map method to take a proc instead.


  #Modify my_map method to take either a proc or a block. It won't be necessary to apply both a proc and a block in the same #my_map call since you could get the same effect by chaining together one #my_map call with the block and one with the proc. This approach is also clearer, since the user doesn't have to remember whether the proc or block will be run first. So if both a proc and a block are given, only execute the proc.
end