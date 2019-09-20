class StaticPagesController < ApplicationController
  def home
    redirect_to mypage_path(current_user) if current_user.present?
  end
end
