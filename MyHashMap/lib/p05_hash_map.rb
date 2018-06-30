require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count
  
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end
  
  def include?(key)
    @store[bucket(key)].include?(key)
  end
  
  def set(key, val)
    if include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
    end
  end
  
  def get(key)
    @store[bucket(key)].get(key)
  end
  
  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end
  
  def each(&prc)
    @store.each do |lst|
      lst.each do |node|
        k = node.key
        v = node.val
        prc.call(k,v)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end
  
  alias_method :[], :get
  alias_method :[]=, :set
  
  private
  
  def num_buckets
    @store.length
  end
  
  def resize!
  end
  
  def bucket(key)
    key.hash % num_buckets
  end
end
