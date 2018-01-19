class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    respond_to do |format|
      @users = current_user.school ? current_user.school.users : User.all
      format.json
      format.html
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow certain attributes to be updated over the web.
    def user_params
      allowed = [:login, :email, :password, :password_confirmation,
                :phone, :picture]

      if current_user.is_administrator_at?(@user.school)
        allowed += [:gender, :birth_date, :name]
      end

      params.require(:user).permit(*allowed)
    end

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user) ||
                                current_user.is_administrator_at?(@user.school)
    end
end
