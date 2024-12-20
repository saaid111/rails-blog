require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(username: 'testuser', email: 'test@example.com', password: 'password123') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      post = Post.new(
        title: 'Test Post',
        content: 'Test content',
        user: user
      )
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(title: nil)
      expect(post).not_to be_valid
    end

    it 'is not valid without content' do
      post = Post.new(content: nil)
      expect(post).not_to be_valid
    end
  end
end