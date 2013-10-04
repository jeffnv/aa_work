class Question < ActiveRecord::Base
  attr_accessible :poll_id, :question_body
  validates :poll_id, presence: true
  validates :question_body, presence: true

  belongs_to(
  :poll,
  class_name: 'Poll',
  foreign_key: :poll_id,
  primary_key: :id
  )

  has_many(
  :answer_choices,
  class_name: 'AnswerChoice',
  foreign_key: :question_id,
  primary_key: :id
  )

  def results
    responses = Question.joins(<<-SQL)
      LEFT OUTER JOIN answer_choices
      ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN responses
      ON answer_choices.id = responses.answer_choice_id
    SQL
    responses = responses.where("questions.id = ?", self.id)
    p responses
    responses.group('answer_choices.answer_body').count('responses.id')
  end
end
