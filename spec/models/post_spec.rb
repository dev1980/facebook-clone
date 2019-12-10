# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations for 1 post created by a user' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                           user_id: @user.id)
    end

    it 'the post can access to the creator' do
      expect(@post.user).to eq(@user)
    end
  end

  context 'validations for a new post' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.new(content: 'This is the content of post 1',
                       user_id: @user.id)
    end

    it 'checks that post must be valid' do
      expect(@post.valid?).to eq(true)
    end

    it 'checks that content must be present' do
      @post.content = ''
      expect(@post.valid?).to eq(false)
    end

    it 'checks that content must be < 500 characters' do
      @post.content = 'a' * 501
      expect(@post.valid?).to eq(false)
    end

    it 'checks that a posts group must be sorted by newest to oldest' do
      @post.save
      post2 = Post.create(content: 'This is the content of post 2',
                          user_id: @user.id)

      expect(Post.all).to eq([post2, @post])
    end
  end

  context 'associations for 1 post that has 2 comments' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                           user_id: @user.id)
      @comment1 = Comment.create!(content: 'This is the first comment',
                                  user_id: @user.id, post_id: @post.id)
      @comment2 = Comment.create!(content: 'This is the second comment',
                                  user_id: @user.id, post_id: @post.id)
    end

    it 'the post can access the created comments' do
      expect(@post.comments).to eq([@comment2, @comment1])
      expect(@post.comments.count).to eq(2)
    end

    it 'the user can create a new comment' do
      comment3 = @post.comments.create!(content: 'This is the third comment', user_id: @user.id)
      expect(@post.comments).to eq([comment3, @comment2, @comment1])
    end
  end

  context 'associations for 1 post that has 2 likes' do
    before :example do
      @user1 = User.create!(name: 'Dev',
                            email: 'dev1980@gmail.com',
                            password: 'password123',
                            password_confirmation: 'password123')

      @user2 = User.create!(name: 'Miguel',
                            email: 'mapra@gmail.com',
                            password: 'password123',
                            password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                           user_id: @user1.id)

      @like1 = Liking.create!(user_id: @user1.id, post_id: @post.id)
      @like2 = Liking.create!(user_id: @user2.id, post_id: @post.id)
    end

    it 'the post can access to its likes' do
      expect(@post.likings).to eq([@like1, @like2])
      expect(@post.likings.count).to eq(2)
    end
  end
end
