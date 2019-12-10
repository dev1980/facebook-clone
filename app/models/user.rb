# frozen_string_literal: true

class User < ApplicationRecord
  before_save :format_attributes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likings
  has_many :sent_requests, foreign_key: :sender_id, class_name: 'Friendship'
  has_many :received_requests, foreign_key: :receiver_id, class_name: 'Friendship'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }

  def already_like?(post)
    Liking.exists?(user_id: id, post_id: post.id)
  end

  def like(post)
    return if already_like?(post)

    likings.create(post_id: post.id)
  end

  def dislike(post)
    like = Liking.find_by(user_id: id, post_id: post.id)
    like&.destroy
  end

  def friends
    friends_array = received_requests.map do |u|
      u.sender if u.confirmed
    end
    friends_array += sent_requests.map do |u|
      u.receiver if u.confirmed
    end
    friends_array.compact
  end

  def pending_friends
    sent_requests.map { |u| u.receiver unless u.confirmed }.compact
  end

  def friend_requests
    received_requests.map { |u| u.sender unless u.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = received_requests.find { |u| u.sender == user }
    friendship.confirmed = true
    friendship.save
  end

  def send_friend_request(user)
    sent_requests.create(receiver_id: user.id)
  end

  def friend?(user)
    friends.include?(user)
  end

  def friends_posts
    friend_ids = friends.map(&:id)

    Post.where('user_id IN (?)', friend_ids)
  end

  private

  def format_attributes
    email.downcase!
    name.capitalize!
  end
end
