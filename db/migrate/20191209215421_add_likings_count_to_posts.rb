class AddLikingsCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :likings_count, :integer
  end
end
