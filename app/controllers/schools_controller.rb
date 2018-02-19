class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:edit, :update]
  before_action :check_global_admin, only: [:new, :create]

  def show
  end

  def new
    @school = School.new
  end

  def edit
  end

  def create
    @school = School.new(school_params)
    if @school.save
      flash[:success] = "Created school"
      redirect_to @school
    else
      render :new
    end
  end

  def update
    if @school.update(school_params)
      flash[:success] = "Updated school"
      redirect_to @school
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(:name)
    end

    def check_admin
      unless current_user.is_administrator_at?(@school) || current_user.admin?
        redirect_to root_url
      end
    end

    def check_global_admin
      unless current_user.admin?
        redirect_to root_url
      end
    end
end
