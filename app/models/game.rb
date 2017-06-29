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
  	deal_cards
  	self.tiles_played = []
  	self.status = 'Active'
    self.turn = 1
    save_players
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

  def good_tiles(tiles)
    tiles.select{ |tile| tile[0] == tile[1] }.size > 4
  end

  def deal_cards
    self.game_players.each do |player| 
      player.tiles = @tiles.slice!(0, 7) 
    end  
    if self.game_players.any? { |e| good_tiles(e.tiles) }
      shuffle_tiles
      deal_cards
    end
  end

  def save_players
    self.game_players.each {|player| player.save }
  end

  # def play(player, move)
  #   if self.turn % 4 == player.player_order && player.tiles.include(tile)
  #     if valid_right(move) || valid_left(move)
  #       player.tiles   
  #     else
         
  #     end 
     
  #   end
  # end

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
    if move.tile[0] == self.tiles_played.flatten[-1]
      update_end_pieces(move.side, move.tile)
    elsif move.tile[1] == self.tiles_played.flatten[-1]
      move.tile = swap_tile_around(move.tile)
      update_end_pieces(move.side, move.tile)
    else 
      nil
    end
  end

  def valid_left(move)
    if move.tile[0] == self.tiles_played.flatten[0]
      move.tile = swap_tile_around(move.tile)
      update_end_pieces(move.side, move.tile)
    elsif move.tile[1] == self.tiles_played.flatten[0]
      update_end_pieces(move.side, move.tile)
    else 
      nil
    end
  end

end
