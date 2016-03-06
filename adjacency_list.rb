require 'pry'

class Edge

  attr_reader :ending, :weight
  attr_accessor :next
  
  def initialize(ending, weight = 1)
    @ending = ending
    @weight = weight
    @next = nil
  end

  def self.add_to_tail(current, insertion_edge)
    current.next ? self.add_to_tail(current.next, insertion_edge) : current.next = insertion_edge
  end

end


class AdjacencyList

  attr_reader :list

  def initialize
    @list = {}
  end

  def add(vertex)
    list[vertex] = nil
  end

  def include?(vertex)
    list.keys.include?(vertex)
  end

  def connect(starting, ending, weight = nil)
    if include?(starting) and include?(ending) 
      new_connection = Edge.new(ending)
      list[starting] ? Edge.add_to_tail(list[starting], new_connection) : list[starting] = new_connection
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
    connection = list[current]
    while connection do 
      return true if connection.ending == ending or connected_dfs?(connection.ending, ending)
      connection = connection.next
    end
    false
  end

  def to_s
    list.each_with_object([]) do |(vertex, edge), memo|
      connection_string = vertex.to_s
      while edge
        connection_string += " -->#{edge.ending}"
        edge = edge.next
      end
      memo << connection_string
    end.join("\n")
  end

end

my_graph = AdjacencyList.new
my_graph.add(:a)
my_graph.add(:b)
my_graph.add(:c)
my_graph.connect(:a, :b)
my_graph.connect(:b, :c)
my_graph.connect(:c, :b)
binding.pry
puts "eof"