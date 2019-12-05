# frozen_string_literal: true

class User < ApplicationRecord
  before_save :format_attributes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likings

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

  private

  def format_attributes
    email.downcase!
    name.capitalize!
  end
end
