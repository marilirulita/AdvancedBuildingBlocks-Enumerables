module Enumerable
  # my_each,
  def my_each
    a = 0
    while a < size
      yield self[a]
      a += 1
    end
    self
  end

  # my_each_with_index in the same way.
  def my_each_with_index
    a = 0
    b = 0
    while a < size
      yield self[a], b
      a += 1
      b = a
    end
    self
  end

  # my_select
  def my_select
      a = 0
      new_arr = []
      while a < size
        if yield self[a] then new_arr.push(self[a]) end
        a += 1
      end
      new_arr
    end

  # my_all? (continue as above)
  def my_all?(s = nil)
    a = 0
    b = true
    while a < size
      if block_given?
        unless yield self[a]
          b = false
        end
      else
        if s.is_a? Class
          b = false if self[a].class.superclass != s
        else
          s = s.to_s
          b = false unless self[a].include?(s)
        end
      end
      a += 1
    end
    b
  end

  # my_any?
  def my_any?(s = true)
    a = 0
    b = false
    while a < size
      if block_given?
        if yield self[a]
          b = true
        end
      else
        if s.is_a? Class
          b = true if self[a].class == s
        else
          s = s.to_s
          c = self[a].to_s
          b = true if c.include?(s)
        end
      end
      a += 1
    end
    b
  end

  # my_none?
  def my_none?(s = true)
    a = 0
    b = true
    while a < size
      if block_given?
        if yield self[a]
          b = false
        end
      else
        if s.is_a? Class
          b = false if self[a].class == s
        else
          s = s.to_s
          c = self[a].to_s
          b = false if c.include?(s)
        end
      end
      a += 1
    end
    b
  end

  # my_count
  def my_count(a = nil)
    b = 0
    c = 0
    if block_given?
      while c < size
        if yield self[c]
          b += 1
        end
        c += 1
      end
    else
      if a == nil
        b = size
      else
        while c < size
          if self[c] == a
            b += 1
          end
          c += 1
        end
      end
    end
    b
  end

  # my_map
  def my_map(b = nil)
    a = []
    d = self.to_a
    c = 0
    while c < size
      a.push(yield d[c])
      c += 1
    end
    a
  end

  # my_inject
  def my_inject(a = nil)
    b = self.to_a
    c = 0
    if a == nil
      a = b[0]
      c = 1
    end
    while c < size
      x = yield(a, b[c])
      a = x
      c += 1
    end
    a
  end
end

# Test my_inject
def multiply_els(m)
  m.my_inject { |x, l| x * l }
end
puts multiply_els([2, 4, 5])
