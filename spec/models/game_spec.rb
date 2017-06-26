require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:users) {[
    user1 = create(:user),
    user2 = create(:user, email: 'email1@email.com', password: 'paswords'), 
    user3 = create(:user, email: 'email2@email.com', password: 'paswords'),
    user4 = create(:user, email: 'email3@email.com', password: 'paswords')
  
  ]}

  let(:game_with_users){
    Game.make(users)
  }

  describe 'initialize' do
    it "doesn't save without users" do
      game1 = Game.new
      game2 = Game.make(users)

      expect(game1.valid?).to equal(false)
      expect(game1.errors.full_messages).to eq([
      	"Users is the wrong length (should be 4 characters)" 
      ])
      expect(game2.errors.full_messages).to eq([])
      expect(game2.valid?).to equal(true)
    end


    it 'assigns each their order' do
       game = game_with_users
       game.save

       expect(game.id).not_to equal(nil)
       expect(game.users[0].my_tiles).not_to equal(nil)
    end

    it 'gives each player seven dominos' do

    end

    it 'has an empty array of tiles played' do
      

    end

    it 'has a status of active' do

    end

  end

end
