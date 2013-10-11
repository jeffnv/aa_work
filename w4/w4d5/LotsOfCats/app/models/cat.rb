class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex, :user_id
  validates :age, :birth_date, :color, :name, :sex,:user_id,  :presence => true
  validates :age, :numericality => true
  validates :color, :inclusion => { :in => %w{brown black white orange} }
  validates :sex, :inclusion => { :in => %w{M F} }

  has_many :cat_rental_requests, :dependent => :destroy
  belongs_to :user

  def approved_requests
    self.cat_rental_requests.where(status: "APPROVED")
  end
end