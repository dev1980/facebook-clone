require 'rails_helper'

RSpec.describe Liking, type: :model do
  context 'associations for 1 post created by a user' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                           user_id: @user.id)

     @like = Liking.create!(user_id: @user.id, 
                            post_id: @post.id)                            
    end

    it 'the like can access to the user' do
      expect(@like.user).to eq(@user)
    end

    it 'the like can access to the post' do
      expect(@like.post).to eq(@post)
    end
  end
end
