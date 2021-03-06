# frozen_string_literal: true

class Liking < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
end
