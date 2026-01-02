# frozen_string_literal: true

require_relative 'node'

class Board
  DIMENSION = 8
  def initialize
    @tiles = Array.new(DIMENSION) { Array.new(DIMENSION) { nil } }
  end

  def valid_moves(position)
    knight_moves = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
    knight_moves.select do |move|
      row = move[0] += position[0]
      col = move[1] += position[1]
      [col, row] if valid_position?(col) && valid_position?(row)
    end
  end

  def knight_move(start_point, end_point)
    create_tiles

    assign_parents(start_point, end_point)
    path = path(end_point)

    puts "=> You made it in #{path.length - 1} moves! Here's your path:"
    path.each { |cord| p cord.position }
  end

  private

  def queue_starting_point(start_point, queue)
    # Queues start point and returns start point's edges(neighbours)
    start_node = tile(start_point)
    queue << start_node
    start_node.visited = true
    start_node.edges = assign_edges(start_node)
  end

  def handle_tile(tile, parent)
    tile.visited = true
    tile.parent = parent
    tile.edges = assign_edges(tile)
  end

  def assign_parents(start_point, end_point, queue = [], edges = queue_starting_point(start_point, queue))
    # Performs a BFS(Breadth-first search) on the board and assigns parents to start_point's edges(neighbours).
    until tile(end_point).parent
      first = queue.shift
      edges.each do |edge|
        tile = tile(edge)
        next if tile.visited

        handle_tile(tile, first)
        queue << tile
      end
      edges = queue.first&.edges
    end
  end

  def assign_edges(node)
    return unless node.edges.empty?

    valid_moves(node.position).each do |edge|
      node.edges << edge
    end
  end

  def path(end_point)
    path = []
    target = tile(end_point)
    until target.nil?
      path.unshift target
      target = target.parent
    end

    path
  end

  def create_tiles
    tiles.each_with_index do |tile, tile_index|
      tile.each_with_index do |_item, item_index|
        tiles[tile_index][item_index] = Node.new([tile_index, item_index])
      end
    end
  end

  def valid_position?(pos)
    pos.between?(0, 7) # Lowest index in board [0], Highest index in board [7]
  end

  def tile(position)
    tiles[position[0]][position[1]] # Returns a tile(node) with the given position [x, y]
  end

  attr_reader :tiles
end
