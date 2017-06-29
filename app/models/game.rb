class Game < ApplicationRecord
	validates :users, length: { is: 4 }
	has_many :game_players
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
  		player.tiles = @tiles.slice(0, 7) 
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

  def 

  def play({player,tile})
    if self.turn % 4 == player.player_order && player.tiles.include(tile)
      self.tiles_played << tile
      player.tiles.delete(tile) 
    end

  end

  def valid_move(tile)
    
  end

  def method_name
    
  end

  def update_state
    
  end

end
