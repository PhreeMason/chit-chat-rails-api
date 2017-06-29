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

  def play(player, move)
    if self.turn % 4 == player.player_order && player.tiles.include?(move[:tile])
      self.turn == 1 ? first_turn(player, move) : later_turn(player, move)
    end
  end

  def later_turn(player, move)
    if valid_right(move) || valid_left(move)
        player.tiles.delete(move[:tile])
        player.save
        self.turn ++
        self.save   
    else
      return nil
    end 
  end

  def first_turn(player, move)
    self.tiles_played << move[:tile]
    player.tiles.delete(move[:tile])
    player.save
    self.save
  end

  def swap_tile_around(tile)
    tile << tile[0]
    tile.delete_at(0)
    tile
  end

  def valid_right(move)
    if move[:side] == 'right'
      return nil
    end
    if move[:tile][0] == self.tiles_played.flatten[-1]
      self.tiles_played << move[:tile]
    elsif move[:tile][1] == self.tiles_played.flatten[-1]
      move[:tile] = swap_tile_around(move[:tile])
      self.tiles_played << move[:tile]
    else 
      nil
    end
  end

  def valid_left(move)
    if move[:side] == 'left'
      return nil
    end
    if move[:tile][0] == self.tiles_played.flatten[0]
      move[:tile] = swap_tile_around(move[:tile])
      self.tiles_played.unshift(move[:tile])
    elsif move[:tile][1] == self.tiles_played.flatten[0]
      self.tiles_played.unshift(move[:tile])
    else 
      nil
    end
  end

end
