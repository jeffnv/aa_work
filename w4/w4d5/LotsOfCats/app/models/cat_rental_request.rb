class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status
  validates :cat_id, :start_date, :end_date, :status, :presence => true
  validates :status, :inclusion => { in: %w{PENDING APPROVED DENIED} }
  validate :no_two_approved_requests_can_overlap

  belongs_to :cat

  before_validation(on: :create) do
    self.status ||= "PENDING"
  end

  def approve!
    self.status = "APPROVED"
    self.transaction do
      overlapping_pending_requests.each do |request|
        request.status = "DENIED"
        request.save!
      end
      self.save!
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    self.status == "PENDING"
  end

  def no_two_approved_requests_can_overlap
    if self.status == "APPROVED" && overlapping_approved_requests.count > 0
      errors[:status] << "can't overlap with another approved request"
    end
  end

  def overlapping_requests
    requests = CatRentalRequest.where("cat_id = ? AND id != ?", self.cat_id, self.id)

    requests.select do |request|
      (start_date <= request.end_date && request.start_date <= end_date)
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select{|request| request.status == "APPROVED"}
  end

  def overlapping_pending_requests
    overlapping_requests.select{|request| request.status == "PENDING"}
  end
end