# frozen_string_literal: true

class User < ApplicationRecord
  before_save :format_attributes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

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
    friendships = sent_requests.includes(:receiver).where(confirmed: true).references(:users)
    friendships.map(&:receiver)
  end

  def pending_friends
    requests = sent_requests.includes(:receiver).where(confirmed: false).references(:users)
    requests.map(&:receiver)
  end

  def friend_requests
    requests = received_requests.includes(:sender).where(confirmed: false).references(:users)
    requests.map(&:sender)
  end

  def confirm_friend(user)
    friendship = received_requests.find { |u| u.sender == user }
    friendship.confirmed = true
    friendship.save

    sent_requests.create(receiver_id: user.id, confirmed: true)
  end

  def send_friend_request(user)
    return if Friendship.exists?(sender_id: id, receiver_id: user.id) || user.id == id

    sent_requests.create(receiver_id: user.id)
  end

  def friend?(user)
    friends.include?(user)
  end

  def friends_posts
    friend_ids = friends.map(&:id)
    Post.where('user_id IN (?) OR user_id=?', friend_ids, id)
  end

  def self.from_omniauth(auth)
    existing_user = find_by(email: auth.info.email)
    if existing_user
      existing_user.update_attributes(provider: auth.provider, uid: auth.uid)
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name # assuming the user model has a name
      end
    end
  end

  private

  def format_attributes
    email.downcase!
    name.capitalize!
  end
end
