require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        username: 'testuser',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user = User.new(username: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil)
      expect(user).not_to be_valid
    end
  end
end
