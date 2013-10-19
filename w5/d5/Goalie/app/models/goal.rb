class Goal < ActiveRecord::Base
  GOAL_STATUSES = ["Not Started", "In Progress", "Complete"]
  GOAL_VISIBILITY = ["Public", "Private"]
  
  attr_accessible :user_id, :goal_info, :status, :visibility
  
  after_initialize :ensure_status, :ensure_visibility
  
  validates_presence_of :user_id, :goal_info, :status, :visibility
  validates :status, inclusion: GOAL_STATUSES
  validates :visibility, inclusion: GOAL_VISIBILITY
  
  belongs_to :user
  
  def ensure_status
    self.status ||= GOAL_STATUSES[0]
  end
  
  def ensure_visibility 
    self.visibility ||= GOAL_VISIBILITY[0]
  end
end
