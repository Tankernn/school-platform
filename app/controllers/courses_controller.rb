class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :check_can_edit, only: [:edit, :update]
  before_action :check_can_create, only: [:create]

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Created course"
      redirect_to @course
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      flash[:success] = "Updated course"
      redirect_to @course
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :school_id, :starts_on, :ends_on)
    end

    def check_can_create
      unless current_user.is_administrator_at?(School.find(course_params[:school_id])) || current_user.admin?
        redirect_to root_url
      end
    end

    def check_can_edit
      unless current_user.is_administrator_at?(@course.school) || current_user.admin?
        redirect_to root_url
      end
    end
end
