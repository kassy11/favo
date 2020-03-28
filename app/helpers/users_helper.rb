# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=250"
    gravatar_url
  end
end
