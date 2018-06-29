class HashSet
  attr_reader :count
  
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  
  def insert(key)
    unless include?(key)
      resize! if count >= num_buckets
      @store[bucket_id(key)] << key
      @count += 1
    end
  end
  
  def include?(key)
    self[bucket_id(key)].include?(key)
  end
  
  def remove(key)
    if include?(key)
      @store[bucket_id(key)].delete(key)
      @count -= 1
    end
  end
  
  private
  
  def [](num)
    @store[num]
  end
  
  def num_buckets
    @store.length
  end
  
  def bucket_id(key)
    key.hash % num_buckets
  end
  
  def resize!
    answer = HashSet.new(num_buckets * 2)
    @store.each do |arr|
      arr.each do |el|
          answer.insert(el)
      end
    end
    @self = answer
  end
end
