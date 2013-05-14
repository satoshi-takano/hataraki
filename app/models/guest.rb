class Guest < ActiveRecord::Base
  belongs_to :work
  attr_accessible :login_id, :login_password, :work_id
  validates_presence_of :login_id, :login_password, :work_id
  validates_numericality_of :work_id
end
