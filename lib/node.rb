# frozen_string_literal: true

class Node
  def initialize(position)
    @position = position
    @visited = false
    @parent = nil
    @edges = []
  end

  attr_accessor :position, :visited, :edges, :parent
end
