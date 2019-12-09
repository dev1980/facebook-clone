class PopulatePostLikingsCount < ActiveRecord::Migration[6.0]
  def change
    def up
      Post.find_each do |post|
        Post.reset_counters(post.id, :likings)
      end
    end
  end
end
