module Enumerable
  # my_each,
  def my_each
    return to_enum unless block_given?

    size.times do |a|
      is_a?(Range) ? yield(min + a) : yield(self[a])
    end
    self
  end

  # my_each_with_index in the same way.
  def my_each_with_index
    return to_enum unless block_given?

    size.times do |a|
      is_a?(Range) ? yield(min + a, a) : yield(self[a], a)
    end
    self
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
  def my_all?(*par)
    my_each do |a|
      if !par[0].nil?
        return false unless par[0] === a
      elsif block_given?
        return false unless yield a
      else
        return false unless a
      end
    end
    true
  end

  # my_any?
  def my_any?(*par)
    b = false
    my_each do |a|
      if block_given?
        b = true if yield a
      elsif !par[0].nil?
        b = true if par[0] === a
      else
        b = true if a
      end
    end
    b
  end

  # my_none?
  def my_none?(par = nil, &block)
    !my_any?(par, &block)
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
  def my_map(proc_ = nil)
    a = []
    if block_given? || proc_
      if proc_
        my_each {|b| a.push(proc_.call(b))}
      else
      my_each {|b| a.push(yield b)}
      end
      a
    else
      return to_enum
    end
  end

  # my_inject
  def my_inject(par1 = nil, par2 = nil)
    if !block_given?
      if par2.nil?
        par2 = par1
        par1 = nil
      end
      par2.to_sym
      my_each {|a| par1 = par1.nil? ? par1 = a : par1.send(par2, a)}
    else
      my_each {|a| par1 = par1.nil? ? par1 = a : yield(par1, a)}
    end
    par1
  end
end

# Test my_inject
def multiply_els(par)
  par.my_inject { |x, l| x * l }
end
