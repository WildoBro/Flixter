class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:new, :create]
  before_action :require_authorized_for_current_section, only: [:update]
  
  def new
    @section = Section.new
  end

  def create
    @section = current_course.sections.create(section_params)
    redirect_to instructor_course_path(current_course)
  end

  def update

  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: "Unautherized", status: :unauthorized
    end
  end

  def require_authorized_for_current_section
    if current_section.user != current_user
      render text: "Unautherized", status: :unauthorized
  end

  helper_method :current_course
  def current_course
    if params[:course_id]
      @current_course ||= Course.find(params[:course_id])
    else
      current_section.course
    end
  end

  helper_method
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end
end

# added helper_method (current_section)
# added the before_action (before_action :require_authorized_for_current_section, only: [:update])
# added the [:new, :create] to line 3