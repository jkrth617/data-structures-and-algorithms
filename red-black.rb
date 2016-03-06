class Node

  attr_reader :value
  attr_accessor :parent, :left, :right, :red
  
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
    @red = true
  end

  def grandparent
    parent.parent
  end

  def uncle
    parent.value <= grandparent.value ? grandparent.right : grandparent.left
  end

end


class RedBlack

  attr_accessor :root

  def initialize(node=nil)
    @root = node
  end

  def empty?
    !root
  end

  def insert(new_value)
    insert_node = Node.new(new_value)
    empty? ? self.root = insert_node : binary_insert(insert_node, root)
    validate_tree(insert_node)
  end

  def binary_insert(new_node, current)
    methods = (new_node.value <= current.value ? [:left, :left=] : [:right, :right=])
    if current.send(methods[0])
      binary_insert(new_node, current.send(methods[0]))
    else
      current.send(methods[1], new_node)
      new_node.parent = current
    end
  end

  def validate_tree(current)
    black_root_check(current)
    red_to_red_check(current) unless current == root
  end

  def black_root_check(current)
    current.red= false unless current.parent
  end

  def zig_zig?(current)
    elder_direction = current.grandparent.value - current.parent.value
    my_direction = current.parent.value - current.value
    (elder_direction > 0 and my_direction > 0) or (elder_direction <= 0 and my_direction <= 0) 
  end

  def red_to_red_check(current)
    if current.parent.red
      check_after = current.grandparent
      if current.uncle and current.uncle.red
        recolor_correct(current)
      else
        zig_zig?(current) ? zig_zig_correct(current) : zig_zag_correct(current)
      end
      validate_tree(check_after)
    end
  end

  def recolor_correct(current)
    current.parent.red = false
    current.uncle.red = false
    current.grandparent.red = true
  end

  def get_directional_methods(child_val, parent_val)
    if child_val > parent_val
      [:right=, :left, :left=]
    else
      [:left=, :right, :right=]
    end
  end

  def zig_zag_correct(current)
    directions_array = get_directional_methods(current.value, current.parent.value)
    detached = current.parent
    current.parent = current.grandparent
    current.value > current.parent.value ? current.parent.right = current : current.parent.left = current
    detached.parent = current
    detached.send(directions_array[0], current.send(directions_array[1]))
    current.send(directions_array[2], detached)  
    zig_zig_correct(detached)
  end

  def zig_zig_correct(current)
    directions_array = get_directional_methods(current.value, current.parent.value)
    detached = current.grandparent
    current.parent.parent = detached.parent
    current.parent.red = false
    detached.send(directions_array[0], current.parent.send(directions_array[1]))
    current.parent.send(directions_array[2], detached)
    detached.parent = current.parent
    detached.red = true
    if current.grandparent #as in there is a node here and its not the new root we need to reattach this sub-tree
      current.grandparent.value > current.parent.value ? current.grandparent.left = current.parent : current.grandparent.right = current.parent
    else #it is the new root
      self.root = current.parent
    end
  end

end