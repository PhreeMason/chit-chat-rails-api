class Game < ApplicationRecord
	validates :users, length: { is: 4 }
	has_many :game_players
  has_many :users, through: :game_players
	after_create :distribute_tiles
	attr_accessor :tiles 
 
 # Game setup start
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

  # Game setup end

  # Game play

  def play(player, move)
    logic = GameLogic.new(self, player, move)
    if self.turn == 1
      update_state(move)
      update_classes(move, player)
    elsif logic.valid_move?
      update_state(logic.good_move)
      update_classes(move, player)
      check_game_status(logic)
    else
      return 'invalid move'
    end
  end

  def update_state(move)
    case move[:side]
    when 'right'
      self.tiles_played << move[:tile]
    when 'left'
      self.tiles_played.unshift(move[:tile])
    end
    self.turn += 1
  end

  def update_classes(move, player)
    player.tiles.delete(move[:tile])
    save_players
    self.save
  end

  def check_game_status(logic)
    if logic.game_over?
      self.status = 'Complete'
    end
  end

end
