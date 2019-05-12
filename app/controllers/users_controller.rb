class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = User.find_by(id: current_user.id)
  end
end
