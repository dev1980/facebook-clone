class User < ApplicationRecord
  before_save :format_attributes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }

  private

  def format_attributes
   email.downcase!
   name.capitalize!
  end
end
