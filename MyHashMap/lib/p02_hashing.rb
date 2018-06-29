class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return self.object_id.hash if self.empty?
    self.reduce{ |el| el.hash} 
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    seed = 0
    self.split("").each_with_index {|c,i| seed += (alphabet.find_index(c.downcase) % (i+1))}
    seed *= self.length
    seed.hash
    end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    seed = 0
    self.each do |k,v|
      seed += k.hash - v.hash
    end
    seed
  end
end
