class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :show

  validates_uniqueness_of :user_id, :scope => [:show_id]
end