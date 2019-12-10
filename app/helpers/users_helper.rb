# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, **options)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: options[:class])
  end
end
