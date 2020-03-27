# frozen_string_literal: true

module LoginMacros
  def login_user(user)
    controller.stub(:authenticate_user!).and_return true
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end
