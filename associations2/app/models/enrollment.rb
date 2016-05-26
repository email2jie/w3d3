# t.integer  "course_id"
# t.integer  "student_id"
class Enrollment < ActiveRecord::Base
  belongs_to :course,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: 'Course'

  belongs_to :user,
    primary_key: :id,
    foreign_key: :student_id,
    class_name: 'User'


end
