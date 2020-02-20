class RegistrationsController < Devise::RegistrationsController

  protected
  def after_update_path_for(resource)
      user_path(resource)
  end

  def update_resource(resource, params)
    if current_user.uid.present? || current_user.provider.present?
      resource.update_without_password(params)
    else
      super
    end
  end
end