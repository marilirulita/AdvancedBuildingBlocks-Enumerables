module Enumerable
  # my_each,
  def my_each
    if block_given?
    size.times do |a|
      yield self[a]
    end
    self
    else
      return to_enum
    end
  end

  # my_each_with_index in the same way.
  def my_each_with_index
    if block_given?
    size.times do |a|
      yield self[a], a
    end
    self
    else
      return to_enum
    end
  end

  # my_select
  def my_select
    new_arr = []
    my_each do |a|
      new_arr.push(a) if yield a
    end
    new_arr
  end

  # my_all? (continue as above)
  def my_all?(par = nil)
    b = true
    my_each do |a|
      if par.is_a? Class
        b = false if a.class.superclass != par
      elsif block_given?
        b = false unless yield a
      else
        par = par.to_s
        b = false unless a.include?(par)
      end
    end
    b
  end

  # my_any?
  def my_any?(par = true)
    b = false
    my_each do |a|
      if block_given?
        b = true if yield a
      elsif par.is_a? Class
        b = true if a.class == par
      else
        s = par.to_s
        c = a.to_s
        b = true if c.include?(s)
      end
    end
    b
  end

  # my_none?
  def my_none?(par = true)
    b = true
    my_each do |a|
      if block_given?
        b = false if yield a
      elsif par.is_a? Class
        b = false if a.class == par
      else
        s = par.to_s
        c = a.to_s
        b = false if c.include?(s)
      end
    end
    b
  end

  # my_count
  def my_count(par = nil)
    b = 0
    if block_given?
      my_each do |a|
        b += 1 if yield a
      end
    elsif par.nil?
      b = size
    else
      my_each do |a|
        b += 1 if a == par
      end
    end
    b
  end

  # my_map
  def my_map(*)
    a = []
    d = to_a
    d.my_each do |b|
      a.push(yield b)
    end
    a
  end

  # my_inject
  def my_inject(par = nil)
    b = to_a
    b.my_each do |a|
      if par.nil?
        par = a
      else
        x = yield(par, a)
        par = x
      end
    end
    par
  end
end

# Test my_inject
def multiply_els(par)
  par.my_inject { |x, l| x * l }
end
