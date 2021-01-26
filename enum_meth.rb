# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Style/CaseEquality

module Enumerable
  # my_each,
  def my_each
    if block_given?
      size.times do |elm|
        is_a?(Range) ? yield(min + elm) : yield(self[elm])
      end
      self
    else
      to_enum
    end
  end

  # my_each_with_index in the same way.
  def my_each_with_index
    if block_given?
      size.times do |elm|
        is_a?(Range) ? yield(min + elm, elm) : yield(self[elm], elm)
      end
      self
    else
      to_enum
    end
  end

  # my_select
  def my_select
    return to_enum unless block_given?
    
    new_arr = []
    my_each do |a|
      new_arr.push(a) if yield a
    end
    new_arr
  end

  # my_all? (continue as above)
  def my_all?(*par)
    b = true
    my_each do |a|
      if !par[0].nil?
        b = false unless par[0] === a
      elsif block_given?
        b = false unless yield a
      else
        b = false unless a
      end
    end
    b
  end

  # my_any?
  def my_any?(*par)
    b = false
    my_each do |a|
      if block_given?
        b = true if yield a
      elsif !par[0].nil?
        b = true if par[0] === a
      elsif a
        b = true
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
    return to_enum unless block_given? || proc_

    if proc_
      my_each { |b| a.push(proc_.call(b)) }
    else
      my_each { |b| a.push(yield b) }
    end
    a
  end

  # my_inject
  def my_inject(par1 = nil, par2 = nil)
    return raise LocalJumpError, 'Expecting a block or any argument' if !block_given? && par1.nil? && par2.nil?

    if !block_given?
      if par2.nil?
        par2 = par1
        par1 = nil
      end
      par2.to_sym
      my_each { |a| par1 = par1.nil? ? par1 = a : par1.send(par2, a) }
    else
      my_each { |a| par1 = par1.nil? ? par1 = a : yield(par1, a) }
    end
    par1
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Style/CaseEquality

# Test my_inject
def multiply_els(par)
  par.my_inject { |x, l| x * l }
end
