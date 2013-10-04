class Response < ActiveRecord::Base
  attr_accessible :user_id, :answer_choice_id
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_creator_of_poll_that_we_are_currently_questioning
  validate :iliketonamelongmethodsnadimgoingtocallthisonefornoreasonalsosomethin


  def respondent_has_not_already_answered_question
    responses_to_nested_queries_made_for_validation_uses = Response.find_by_sql(
    [<<-SQL, self.user_id, self.answer_choice_id])
      SELECT responses.*
      FROM responses JOIN answer_choices
      ON responses.answer_choice_id = answer_choices.id
      WHERE responses.user_id = ?
      AND answer_choices.question_id IN
       (SELECT question_id
        FROM answer_choices
        WHERE id = ?
       )
    SQL

    unless responses_to_nested_queries_made_for_validation_uses.empty?
      msg = "has already made a response to this question"
      self.errors[:user_id] << msg
    end
  end

  def respondent_is_not_creator_of_poll_that_we_are_currently_questioning
    answers = User.joins(:authored_polls => {:questions => :answer_choices})
    unless(answers.where("users.id = ?", self.user_id).empty?)
      msg = "cannot respond to own poll!"
      self.errors[:user_id] << msg
    end
  end

  def iliketonamelongmethodsnadimgoingtocallthisonefornoreasonalsosomethin

  end

  belongs_to(
  :respondent,
  class_name: 'User',
  foreign_key: :user_id,
  primary_key: :id
  )

  belongs_to(
  :answer_choice,
  class_name: 'AnswerChoice',
  foreign_key: :answer_choice_id,
  primary_key: :id
  )


end