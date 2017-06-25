require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it 'requires an email and password and username upon creation' do
      user=build(:user, username: nil, password: nil, email: nil)

      expect(user.valid?).to equal(false) 
      expect(user.errors.full_messages).to eq([
      	"Password can't be blank", 
      	"Email can't be blank",
      	"Email is invalid"	
      ])

    end

    it 'requires a unique email'do
      create(:user) 
      user = build(:user)

      expect(user.valid?).to equal(false)
      expect(user.errors.full_messages).to eq([ 
      	"Email has already been taken"	
      ])

    end


    it 'requires a valid email' do
      user1 = build(:user, email: 'patna.com')
      user2 = build(:user, email: 'patna@email')
      user3 = build(:user, email: 'papa')

      expect(user1.valid?).to equal(false)
      expect(user1.errors.full_messages).to eq([
        "Email is invalid"
      ])

      expect(user2.valid?).to equal(false)
      expect(user3.valid?).to equal(false) 
    end

  end

  describe 'on save' do
    it 'hashes a password' do
      user = build(:user)
      user.save

      expect(user.password_digest).not_to equal(user.password)
    end
  end

  
  describe 'relationships' do
  	it 'has many games'

    it 'has many'
  	
  end
   
end
