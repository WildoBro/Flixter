class User < ActiveRecord::Base
  has_many :courses
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :sections, through: :enrolled_courses
  has_many :lessons, through: :sections
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def enrolled_in?(course)
    enrolled_courses.include?(course)
  end

end