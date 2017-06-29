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

  def play(player,tile)
    if self.turn % 4 == player.player_order && player.tiles.include(tile)
      self.tiles_played << tile
      player.tiles.delete(tile) 
    end

  end

  def valid_move(tile)
    
  end

  def all_tiles_good
    tiles = @tiles.slice!(0, 7)
    while good_tiles(tiles) > 3
      @tiles+= tiles
      @tiles.shuffle
      tiles = @tiles.slice!(0, 7)
    end
    tiles
  end

  def good_tiles(tiles)
    tiles.select{ |tile| tile[0] == tile[1] }.size
  end

  # def update_state(tile)
  #   if self.end_pieces.empty?
  #     self.end_pieces = tile

  #   else
  #     7

  #   end 
    
  # end

end
