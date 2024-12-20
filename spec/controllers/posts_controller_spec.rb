require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  # Create a user for testing
  let(:user) { User.create(username: 'testuser', email: 'test@example.com', password: 'password123') }
  
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      post = Post.create!(title: 'Test Post', content: 'Test Content', user: user)
      get :show, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'when user is logged in' do
      before { session[:user_id] = user.id }

      it 'creates a new post' do
        expect {
          post :create, params: { post: { title: 'New Post', content: 'Some content' } }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the created post' do
        post :create, params: { post: { title: 'New Post', content: 'Some content' } }
        expect(response).to redirect_to(Post.last)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login' do
        post :create, params: { post: { title: 'New Post', content: 'Some content' } }
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { Post.create!(title: 'Test', content: 'Test', user: user) }

    context 'when user is the post owner' do
      before { session[:user_id] = user.id }

      it 'destroys the post' do
        expect {
          delete :destroy, params: { id: post.id }
        }.to change(Post, :count).by(-1)
      end
    end
  end
end