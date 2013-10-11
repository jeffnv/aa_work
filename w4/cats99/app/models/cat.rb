class Cat < ActiveRecord::Base
  CAT_COLORS = %w(orange white brown black gray)
  attr_accessible :age, :birth_date, :color, :name, :sex
  validates :age, :numericality => true
  validates :age, :birth_date, :color, :name, :sex, :presence => true
  validates :sex, :inclusion => { :in => ["M","F"] }
  validates :color, :inclusion => { :in => CAT_COLORS }

  has_many( :rental_requests,
    :dependent => :destroy,
    :foreign_key => :cat_id,
    :primary_key => :id,
    :class_name => "CatRentalRequest"
    )






end