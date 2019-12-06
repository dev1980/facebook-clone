# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations for 1 user that created 2 posts' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post1 = Post.create!(content: 'This is the content of post 1',
                            user_id: @user.id)

      @post2 = Post.create!(content: 'This is the content of post 2',
                            user_id: @user.id)
    end

    it 'the user can access the created posts' do
      expect(@user.posts).to eq([@post2, @post1])
      expect(@user.posts.count).to eq(2)
    end

    it 'the user can create a new post' do
      post3 = @user.posts.create!(content: 'This is the content of post 3')
      expect(@user.posts).to eq([post3, @post2, @post1])
    end
  end

  context 'validations of a new user' do
    before :example do
      @user = User.new(name: 'Dev', email: 'dev1980@gmail.com', password: 'password123',
                       password_confirmation: 'password123')
    end

    it 'checks that the name must be present' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'checks that the name must be < 50 characters' do
      @user.name = 'a' * 51
      expect(@user.valid?).to eq(false)
    end

    it 'checks that email is in the correct format' do
      invalid_emails = %w[myemail.com email@gmail examplegmail.com myemail @gmail.com]
      invalid_emails.each do |email|
        @user.email = email
        expect(@user.valid?).to eq(false)
      end
    end

    it 'checks that email must be present and unique' do
      @user.save
      user2 = @user.dup
      expect(user2.valid?).to eq(false)
    end
  end
end
