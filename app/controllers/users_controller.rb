class UsersController < ApplicationController

  before_action :init_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), nitice: 'Профиль обновлён'
    else
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def init_user
    @user = current_user
  end
end
