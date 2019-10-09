class RegistrationsController < Devise::RegistrationsController
  protected
  def after_update_path_for(resource)
      mypage_path(resource)
  end
end