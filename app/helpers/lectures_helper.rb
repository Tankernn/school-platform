module LecturesHelper
  def can_edit_full?
    current_user.is_course_administrator?(@course)
  end

  def can_edit_description?
    current_user.is_course_teacher?(@course)
  end
end
