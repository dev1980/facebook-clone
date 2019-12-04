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

  def like(post)
    return if Liking.find_by(user_id: id, post_id: post.id)

    likings.create(post_id: post.id)
  end

  def dislike(post)
    like = Liking.find_by(user_id: id, post_id: post.id)
    like.destroy if like
  end
  private

  def format_attributes
    email.downcase!
    name.capitalize!
  end
end
