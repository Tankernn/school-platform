class CourseParticipationsController < ApplicationController

  def create
    @course = Course.find(participation_params[:course_id])
    check_permissions
    @participation = CourseParticipation.new(participation_params)
    @participation.save
    redirect_to @course
  end

  def destroy
    @participation = CourseParticipation.find(params[:id])
    @course = @participation.course
    check_permissions
    @participation.destroy
    redirect_to @course
  end

  private
    def participation_params
      params.require(:course_participation).permit(:course_id,
                                                   :user_id,
                                                   :role)
    end

    def check_permissions
      unless current_user.is_administrator_at?(@course.school) || current_user.admin?
        redirect_to root_url
      end
    end
end
