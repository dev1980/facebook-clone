require 'rails_helper'

RSpec.describe "CommentsLikes", type: :feature do
 
  context 'associations for 1 user that created 2 posts' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                            user_id: @user.id)
      sign_in @user
    end
    it 'can like a post' do
      visit post_path(@post)
      expect(page.current_path).to eq(post_path(@post))
      expect { click_link 'Like' }.to change { @post.likings.count }.by(1)
    end
    it 'can comment the post' do
      visit post_path(@post)
      expect(page.current_path).to eq(post_path(@post))
      click_link 'Comment'
      fill_in 'comment[content]', with: 'content of the comment'
      expect {click_button 'Comment' }.to change { @post.comments.count }.by(1)
    end
  end
end
