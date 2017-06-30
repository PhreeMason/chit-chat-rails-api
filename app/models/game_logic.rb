class GameLogic
  attr_accessor :game, :player, :move

  def initialize(game, player, move)
  	@game = game
  	@player = player
  	@move = move
  end

   def valid_move?
 		case @move[:side]
 	    when 'right'
 		    correct_turn? || @move[:tile].any? { |tile| tile == @game.tiles_played.flatten[-1]} 
 	    when 'left'
 		    correct_turn? || @move[:tile].any? { |tile| tile == @game.tiles_played.flatten[0]}
 	  end   		   	
   end

   def good_move
     case @move[:side]
     when 'right'
       right_move
     when 'left'
     	  left_move
     end
   end

  def swap_tile_around
    @move[:tile] << @move[:tile][0]
    @move[:tile].delete_at(0)
    @move
  end

  def right_move
    if @move[:tile][0] == @gmae.tiles_played.flatten[-1]
      @move 
    else 
      swap_tile_around
    end
  end

  def left_move
    if move[:tile][0] == @game.tiles_played.flatten[0]
      swap_tile_around
    else 
      @move
    end
  end

  def correct_turn?
    if @player.player_order == 4 && @game.turn == 4
      true
    else
      @game.turn % 4 == player.player_order
    end
  end
end
