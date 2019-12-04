# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likings
  validates :content, presence: true,
                      length: { maximum: 500 }
  default_scope -> { order(created_at: :desc) }
end
