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
    unless include?(num)
      resize! if num_buckets <= @count
      @store[bucket_id(num)] << num 
      @count += 1
    end
  end
  
  def remove(num)
    if include?(num)
      self[bucket_id(num)].delete(num)
      @count -= 1 
    end
  end
  
  def include?(num)
    self[bucket_id(num)].include?(num)
  end
  
  private
  
  def [](num)
    @store[num]
  end
  
  def []=(num, value)
    @store[num] = value
  end
  
  def bucket_id(num)
    num % num_buckets
  end
  
  def num_buckets
    @store.length
  end
  
  def resize!
    new_array = Array.new(num_buckets*2) {Array.new}
    
    bucket_length = new_array.length
    
    @store.each do |arr|
      arr.each do |el|
        new_bucket_id = el % bucket_length
        new_array[new_bucket_id] << el 
      end
    end
    
    @store = new_array
  end
end
