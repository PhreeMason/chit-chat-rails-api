require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it 'requires an email and password and username upon creation' do
      user=build(:user, username: nil, password: nil, email: nil)

      expect(user.valid?).to equal(false) 
      expect(user.errors.full_messages).to eq([
      	"Password can't be blank", 
      	"Email can't be blank"	
      ])

    end

    it 'requires a valid email' do
      create(:user) 
      user = build(:user)

      expect(user.valid?).to equal(false)
      expect(user.errors.full_messages).to eq([ 
      	"Email has already been taken"	
      ])

    end


    it 'requires a unique email'

  end

  describe 'on save' do
    it 'hashes a password'

  end

  
  describe 'relationships' do
  	it 'has many games'

    it 'has many'
  	
  end
   
end
