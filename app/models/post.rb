# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likings, dependent: :destroy
  validates :content, presence: true,
                      length: { maximum: 500 }
  default_scope -> { order(created_at: :desc) }
end
