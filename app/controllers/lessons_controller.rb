class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_to_be_registered, only: [:show]

  def show
  end

  private 
  helper_method :current_lesson

  def require_user_to_be_registered
    if !current_user.enrolled_in?(current_lesson.section.course) 
      redirect_to course_path(current_lesson.section.course), alert: "You are not enrolled in this course"
    end
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
