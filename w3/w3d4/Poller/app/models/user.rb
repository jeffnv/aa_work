class User < ActiveRecord::Base
  attr_accessible :user_name
  validates :user_name, presence: true



  has_many(
  :authored_polls,
  class_name: 'Poll',
  primary_key: :id,
  foreign_key: :author_id
  )

  has_many(
  :responses,
  class_name: 'Response',
  primary_key: :id,
  foreign_key: :user_id
  )

  def completed_polls
    # everything = Poll.joins(:questions =>{:answer_choices => {:responses => :respondent}})
    # everything.where('responses.user_id = ?', self.id)
    poll_query = Poll.joins(:questions => {:answer_choices => :responses})

    completed_polls = []
    poll_query.each do |poll|
      poll.where('responses.user_id = ?', self.id).count('responses.*')
    end
    completed_polls


    # count of all responses the user has made to the poll
    Poll.joins(:user => :responses).where('responses.user_id = ?', self.id).count
    User
  end

  def uncompleted_polls
  end
end
