class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)

  before_validation(on: :create) do
      self.status ||= "PENDING"
  end

  attr_accessible :cat_id, :start_date, :end_date, :status
  validates :cat_id, :start_date, :end_date, :status, :presence => true
  validates :status, :inclusion => { :in => STATUSES }
  validate  :invalid_dates, :overlapping_approved_requests


  belongs_to( :cat,
    :foreign_key => :cat_id,
    :primary_key => :id,
    :class_name => "Cat"
    )

  def invalid_dates
    p "rsgjkhsdjfghsdfghsfg"
        p self.start_date.class
    p self.start_date
    p self.end_date
        p self.end_date.class
    if !(self.start_date.is_a?(DateTime) && self.end_date.is_a?(DateTime)) || !(self.start_date.is_a?(ActiveSupport::TimeWithZone) && self.end_date.is_a?(ActiveSupport::TimeWithZone))
        self.errors[:status] << "invalid date type"
        p self.errors
        p "YOYOYOYOYOYOYO"
    end
  end

  def overlapping_approved_requests
    o_lap_starts = CatRentalRequest.where(:start_date => (self.start_date..self.end_date), :status => 'APPROVED')
    o_lap_ends = CatRentalRequest.where(:end_date => (self.start_date..self.end_date), :status => 'APPROVED')
    if( o_lap_ends.count > 0 || o_lap_starts.count > 0)
      errors[:status] << "overlapping requests"
    end
  end

end
