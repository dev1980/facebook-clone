# frozen_string_literal: true

module LikingsHelper
  def like_dislike(post)
    if current_user.already_like? post
      link_to 'Dislike', liking_path(id: post.id), method: :delete
    else
      link_to 'Like', likings_path(post_id: post.id), method: :post
    end
  end
end
