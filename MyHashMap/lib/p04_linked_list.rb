require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev
  
  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end
  
  def to_s
    "#{@key}: #{@val}"
  end
  
  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev 
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end
  
  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end
  
  def first
    @head.next
  end
  
  def last
    @tail.prev
  end
  
  def empty?
    first == @tail
  end
  
  def get(key)
    find_node(key).nil? ? nil : find_node(key).val
  end
  
  def include?(key)
    traveler_node = @head
    until traveler_node == @tail
      traveler_node = traveler_node.next
      return true if traveler_node.key == key
    end
    false
  end
  
  def append(key, val)
    new_node = Node.new(key, val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev = new_node
  end
  
  def update(key, val)
    find_node(key).val = val unless find_node(key).nil?
  end
  
  def remove(key)
    find_node(key).remove
  end
  
  def each(&prc)
    prc ||= Proc.new{|node| node.key }
    traveler_node = @head
    until traveler_node.next == @tail
      traveler_node = traveler_node.next
      p prc.call(traveler_node)
    end
  end
  
   private
  
  def find_node(key)
    traveler_node = @head
    until traveler_node == @tail
      traveler_node = traveler_node.next
      return traveler_node if traveler_node.key == key
    end
    nil
  end
  
  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
