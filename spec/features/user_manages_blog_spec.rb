require 'rails_helper'

RSpec.describe 'User manages blog', type: :feature do
  let!(:user) { User.create!(username: 'testuser', email: 'test@example.com', password: 'password123') }

  before do
    visit sign_in_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    click_button 'Sign In'
  end

  it 'creates a new blog post' do
    visit new_post_path
    
    fill_in 'Title', with: 'Test Blog Post'
    fill_in 'Content', with: 'This is a test blog post content'
    click_button 'Create Post'

    expect(page).to have_content('Post was successfully created')
    expect(page).to have_content('Test Blog Post')
  end

  it 'edits an existing post' do
    post = Post.create!(title: 'Original Post', content: 'Original content', user: user)
    
    visit edit_post_path(post)
    fill_in 'Title', with: 'Updated Post Title'
    click_button 'Update Post'

    expect(page).to have_content('Post was successfully updated')
    expect(page).to have_content('Updated Post Title')
  end

  it 'deletes a post' do
    post = Post.create!(title: 'Delete Test', content: 'To be deleted', user: user)
    visit post_path(post)
    
    # Simple deletion without JavaScript confirmation
    click_button 'Delete'
    
    expect(page).to have_content('Post was successfully deleted')
    expect(page).not_to have_content('Delete Test')
  end
end