class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max){|x| x = false}
  end
  
  def insert(num)
    unless include?(num)
      @store[num] = true
    end
  end
  
  def remove(num)
    if include?(num)
      @store[num] = false
    end
  end
  
  def include?(num)
    if is_valid?(num)
      return @store[num]
    end
    false
  end
  
  private
  
  def is_valid?(num)
    raise "Out of bounds" if num < 0 || num > @max
    true
  end
  
  # def validate!(num)
  # end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end
  
  def insert(num)
    unless include?(num)
      self[bucket_id(num)] << num
    end
  end
  
  def remove(num)
    if include?(num)
      self[bucket_id(num)].delete(num)
    end
  end
  
  def include?(num)
    bucket = self[bucket_id(num)]
    bucket.each { |el| return true if el == num }
    false
  end
  
  private
  
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end
  
  def num_buckets
    @store.length
  end
  
  def bucket_id(num)
    num % num_buckets
  end
end

class ResizingIntSet
  attr_reader :count
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  
  def insert(num)
  end
  
  def remove(num)
  end
  
  def include?(num)
  end
  
  private
  
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end
  
  def num_buckets
    @store.length
  end
  
  def resize!
  end
end
