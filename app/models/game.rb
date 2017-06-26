class Game < ApplicationRecord
	validates :users, length: { is: 4 }
	has_many :game_players
	has_many :users, through: :game_players
	after_create :distribute_tiles
	attr_accessor tiles 
 
  def self.make(users)
    game = Game.new
    users.each{|user| game.users << user}
    game
  end

  def distribute_tiles
  	@tiles.shuffle!
  	self.game_players.each{|player| player.tiles = @tiles.slice(0, 6) }
  	self.tiles_played = []
  end

  def shuffle_tiles
    arr  = ['zero', 'one', 'two', 'three', 'four', 'five', 'six']
    arr1 = ['zero', 'one', 'two', 'three', 'four', 'five', 'six']
    @tiles  = []
    arr.each do |ele| 
      arr1.each do |a| 
        @tiles.push("#{ele}-#{a}") 
      end
      arr1.shift
    end
  end

end
