class Node

  attr_accessor :key, :value, :next

  def initialize(key, val)
    @key = key
    @value = val
    @next = nil
  end

end

class MyHash

  attr_reader :tolerance
  attr_accessor :crypter, :container

  def initialize(size = 5)
    @container = Array.new(size)
    @crypter = "jake"
    @tolerance = 3
  end

  def size
    container.length
  end

  def hash(key_name)
    unless key_name.class == Symbol or key_name.class == String
      puts "invalid key type"
      return nil
    else
      key_name = "¿" + key_name.to_s if key_name.class == "Symbol" #add some obscure ascii char to separate str and sym access
      return (key_name.crypt(crypter).chars.reduce(0) {|sum,c| sum + c.ord})%container.length
    end
  end

  def []=(key, value)
    insert_node = Node.new(key, value)
    index = hash(key)
    if index
      insert(insert_node, container[index], index)
    else
      return false
    end
  end

  def insert(node, insert_location, index=nil)
    if insert_location#collision
      chain(node, insert_location, 0) 
    else
      container[index] = node
    end
  end

  def chain(new_node, current_node, depth)
    return rehash if depth > tolerance
    if current_node.next
      chain(new_node, current_node, depth+=1)
    else
      current_node.next = new_node
    end
  end

  def [](key)
    index = hash(key)
    if index
      return search(container[index], key)
    else
      puts "invalid look up"
    end
  end

  def search(node, target_key)
    unless node
      puts "ele not found"
      return nil
    else
      return node.key == target_key ? node.value : search(node.next, target_key)
    end 
  end

  def rehash
    new_size = container.length*2
    self.crypter +="x"
    puts "\nREHASHING\nsize: #{new_size}\n"
    copy = container.dup
    self.container = Array.new(new_size)
    info = copy.each_with_object([]) do |cell, memo|
      if cell
        memo <<[cell.key, cell.value]
        next_node = cell.next
        while next_node
          memo << [next_node.key, next_node.value]
          next_node = next_node.next
        end
      end
    end
    info.each do |(key,value)|
      self[key]=value
    end
  end

  def to_s
    container.each_with_object([]).with_index do |(ele, memo), index|
      hash_string = index.to_s
      while ele
        hash_string += " -->(#{ele.key},#{ele.value})"
        ele = ele.next
      end
      memo << hash_string
    end.join("\n")
  end

end