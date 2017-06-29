class Game < ApplicationRecord
	validates :users, length: { is: 4 }
	has_many :game_players
  has_many :users, through: :game_players
	after_create :distribute_tiles
	attr_accessor :tiles 
 
  def self.make(users)
    game = Game.new
    users.each{|user| game.users << user}
    game
  end

  def distribute_tiles
  	shuffle_tiles
    assign_order
  	self.game_players.each do |player| 
  		player.tiles = all_tiles_good 
  		player.save
  	end
  	self.tiles_played = []
  	self.status = 'Active'
    self.turn = 1
  	save
  end

  def assign_order
    order  = [1,2,3,4].shuffle!
    self.game_players.each do |player| 
      player.player_order = order.pop 
      player.save
    end
  end

  def shuffle_tiles
    arr  = [0,1,2,3,4,5,6]
    arr1 = [0,1,2,3,4,5,6]
    @tiles  = []
    arr.each do |ele| 
      arr1.each do |a| 
        @tiles.push([ele,a]) 
      end
      arr1.shift
    end
    @tiles.shuffle!
  end 

  def play(player,move)
    if self.turn % 4 == player.player_order && player.tiles.include(tile)
      self.tiles_played << tile
      player.tiles.delete(tile) 
    end

  end

  def valid_move(move)
    
  end

  def all_tiles_good
    tiles = @tiles.slice!(0, 7)
    until good_tiles(tiles) < 5
      @tiles+= tiles
      @tiles.shuffle
      tiles = @tiles.slice!(0, 7)
    end
    tiles
  end

  def good_tiles(tiles)
    tiles.select{ |tile| tile[0] == tile[1] }.size
  end

  def update_end_pieces(side, tile)
    if side == 'right'
      self.tiles_played.unshift(tile)
    else
      self.tiles_played << tile
    end
  end

  def swap_tile_around(tile)
    tile << tile[0]
    tile.delete_at(0)
    tile
  end

  def valid_right(move)
    if move.tile[0] == self.tiles_played.flatten[-1]}
      update_end_pieces(move.side, move.tile)
    elsif move.tile[1] == self.tiles_played.flatten[-1]}
      move.tile = swap_tile_around(move.tile)
      update_end_pieces(move.side, move.tile)
    else 
      nil
    end
  end

  def valid_left(move)
    if move.tile[0] == self.tiles_played.flatten[0]}
      move.tile = swap_tile_around(move.tile)
      update_end_pieces(move.side, move.tile)
    elsif move.tile[1] == self.tiles_played.flatten[0]}
      update_end_pieces(move.side, move.tile)
    else 
      nil
    end
  end

end
