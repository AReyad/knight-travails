# frozen_string_literal: true

require_relative 'lib/board'

board = Board.new
puts '---------------=---------------'
board.knight_move([0, 0], [3, 3])
puts '---------------=---------------'
board.knight_move([0, 0], [7, 7])
puts '---------------=---------------'
board.knight_move([3, 3], [0, 0])
puts '---------------=---------------'
board.knight_move([7, 7], [0, 0])
puts '---------------=---------------'
board.knight_move([3, 3], [4, 3])
puts '---------------=---------------'
