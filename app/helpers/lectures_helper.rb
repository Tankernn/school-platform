module LecturesHelper
  def can_edit_description?
    @lecture.course.users.merge(CourseParticipation.teachers).include?(current_user) || can_edit_full?
  end

  def can_edit_full?
    begin
      school = (@lecture && @lecture.course) ? @lecture.course.school : Course.find(params.require(:lecture)[:course_id]).school
    rescue
      return true
    end

    current_user.is_administrator_at?(school) || current_user.admin?
  end
end
