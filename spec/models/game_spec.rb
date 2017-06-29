require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:users) {[
    user1 = create(:user),
    user2 = create(:user, email: 'email1@email.com', password: 'paswords'), 
    user3 = create(:user, email: 'email2@email.com', password: 'paswords'),
    user4 = create(:user, email: 'email3@email.com', password: 'paswords')
  
  ]}

  let(:game_with_users){
    game = Game.make(users)
    game.save
    game
  }

  let(:players){
    game_with_users.game_players
  }
  

  let(:on_going_game){
    players[0].tiles = [[2, 3], [5, 6], [1, 2], [2, 4], [0, 6], [1, 3]]
    players[1].tiles = [[0, 5], [0, 0], [0, 3], [3, 5], [2, 5], [0, 4]]
    players[2].tiles = [[4, 4], [4, 6], [2, 6], [0, 1], [1, 4], [5, 5]]
    players[3].tiles = [[3, 3], [2, 2], [3, 6], [6, 6], [0, 2], [3, 4], [4, 5]]
    
    players[0].player_order = 1
    players[1].player_order = 2
    players[2].player_order = 3
    players[3].player_order = 4
    
    game_with_users.tiles_played = [[5, 1],[1, 1],[1, 6]]
    game_with_users.save_players
    game_with_users.turn = 4
    game_with_users.save
    game_with_users
  }

  describe 'initialize' do

    it "doesn't save without users" do
      game1 = Game.new
      game2 = Game.make(users)

      expect(game1.valid?).to equal(false)
      expect(game1.errors.full_messages).to eq([
      	"Users is the wrong length (should be 4 characters)" 
      ])
      expect(game2.errors.full_messages).to be_empty
      expect(game2.valid?).to equal(true)
    end


    it 'assigns each their order' do

       expect(game_with_users.id).not_to equal(nil)
       expect(game_with_users.game_players[2].player_order).to be <= 4 
    end

    it 'gives each player seven dominos' do
      expect(players[0].tiles).not_to equal(nil)
      expect(players[3].tiles.size).to equal(7)
    end

    it 'has an empty array of tiles played' do

      expect(game_with_users.tiles_played).to be_empty

    end

    it 'has a status of active and current turn is 1' do

      expect(game_with_users.turn).to eq(1)
      expect(game_with_users.status).to eq('Active')
    end

  end

  describe 'game play' do
    
    it 'allows first player to make their move' do
      
      player = players.detect{|player| player.player_order == 1}
      tile = player.tiles[0]
      player.game.play(player, {tile: tile, side: 'right'})

      expect(game_with_users.tiles_played.length).to eq(1)
      expect(game_with_users.tiles_played).to include(tile)
      expect(player.tiles).not_to include(tile)
    end

    it 'only allows acurate moves' do
      game = on_going_game
      player = game.game_players[3]
      game.play(player, {tile: player.tiles[-1], side: 'left'})

      expect(game.tiles_played).to include([4,5])
    end

  end

end
