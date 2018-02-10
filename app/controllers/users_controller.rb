class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :update]

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

      if can_administer?
        allowed += [:gender, :birth_date, :name]
      end

      if current_user.admin?
        allowed += [:admin]
      end

      params.require(:user).permit(*allowed)
    end

    # Confirms the correct user.
    def check_permission
      redirect_to(root_url) unless can_edit?
    end

    def can_edit?
      current_user?(@user) || can_administer?
    end

    def can_administer?
      current_user.is_administrator_at?(@user.school) || current_user.admin?
    end
end
