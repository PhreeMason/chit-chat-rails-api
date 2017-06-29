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
    
    it 'allows each player to make their move on their turn' do
      
      player = players[0]
      tiles = player.tiles
      game_with_users.turn = player.player_order
      player.game.play(tiles[0])

      expect(game.tiles_played.length).to eq(1)
      expect(game.tiles_played).to include(tiles[0])
      expect(player.tiles).not_to include(tiles[0])
    end

  end

end
