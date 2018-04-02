class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy]
  before_action :check_can_edit, only: [:edit, :update]
  before_action :check_can_create, only: [:create]

  def show
  end

  def new
    @lecture = Lecture.new
  end

  def edit; end

  def create
    @lecture = Lecture.new(lecture_params)
    if @lecture.save
      flash[:success] = 'Created lecture'
      redirect_to @lecture
    else
      render :new
    end
  end

  def update
    if @lecture.update(lecture_params)
      flash[:success] = 'Updated lecture'
      redirect_to @lecture
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lecture
    @lecture = Lecture.find(params[:id])
  end

  def current_course
    begin
      Course.find(params.require(:lecture)[:course_id])
    rescue
      @lecture.course
    end
  end

  def lecture_params
    allowed = [:description]

    allowed += [:course_id, :starts_at, :ends_at, :location] if current_user.is_course_administrator?(current_course)

    params.require(:lecture).permit(*allowed)
  end

  def check_can_create
    redirect_to root_url unless params.require(:lecture)[:course_id] && current_user.is_course_administrator?(current_course)
  end

  def check_can_edit
    redirect_to root_url unless current_user.is_course_teacher?(@lecture.course)
  end
end
