require 'pry'

class Node

  attr_reader :info
  attr_accessor :next

  def initialize(info)
    @info = info
    @next = nil
  end

end

class Q

  attr_accessor :head

  def initialize
    @head = nil
  end

  def empty?
    !head
  end

  def add(insert_info)#not inserting a node but rather a piece of info
    insert_node = Node.new(insert_info)
    if empty?
      self.head = insert_node
    else
      current = head
      while current.next
        current = current.next
      end
      current.next = insert_node
    end
  end

  def remove
    if empty?
      false
    else
      dettached = head
      self.head = head.next
      dettached
    end
  end

end


class Edge

  attr_reader :ending, :weight
  
  def initialize(ending, weight = 1)
    @ending = ending
    @weight = weight
  end

end


class AdjacencyList

  attr_reader :list

  def initialize
    @list = {}
  end

  def add(vertex)
    list[vertex] = []
  end

  def include?(vertex)
    !!list[vertex]
  end

  def connect(starting, ending, weight = nil)
    if include?(starting) and include?(ending) 
      list[starting] << Edge.new(ending)
    else
      puts "invalid connection"
    end
  end

  def connected?(starting, ending, dfs=false)
    if dfs
      puts "Using DFS"
      connected_dfs?(starting, ending)
    else
      puts "Using BFS"
      connected_bfs?(starting, ending)
    end
  end

  def connected_dfs?(current, ending)#current and ending are just the names of the connections NOT an edge obj or anything fancy
    connections = list[current]
    connections.each  do |edge|
      return true if edge.ending == ending or connected_dfs?(edge.ending, ending)
    end
    false
  end

  def connected_bfs?(current, target)#again not nodes but info
    discovered = {}
    search_q = Q.new
    search_q.add(current)
    until search_q.empty? do 
      working = search_q.remove
      return true if working.info == target
      discovered[working.info] = true
      add_all_connections(list[working.info], search_q, discovered)
    end
    false
  end

  def add_all_connections(connection_list, q, discovered)
    connection_list.each do |current|
      q.add(current.ending) unless discovered[current.ending]
    end
  end

  def to_s
    list.each_with_object([]) do |(vertex, connection_array), memo|
      connection_string = vertex.to_s
      connection_array.each do |edge|
        connection_string += " -->#{edge.ending}"
      end
      memo << connection_string
    end.join("\n")
  end

end