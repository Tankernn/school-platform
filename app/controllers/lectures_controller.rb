class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[show edit update destroy]
  before_action :check_can_edit, only: %i[edit update]
  before_action :check_can_create, only: %i[create]

  def show; end

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

  def lecture_params
    allowed = [:description]

    allowed += %i[course_id starts_at ends_at location] if helpers.can_edit_full?

    params.require(:lecture).permit(*allowed)
  end

  def check_can_create
    redirect_to root_url unless helpers.can_edit_full?
  end

  def check_can_edit
    redirect_to root_url unless helpers.can_edit_description?
  end
end
