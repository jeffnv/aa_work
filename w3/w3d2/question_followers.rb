class QuestionFollowers
  def self.followers_for_question_id(question_id)
    query = <<-SQL
    SELECT users.id, users.fname, users.lname
    FROM question_followers
    JOIN users
    ON (users.id = question_followers.user_id)
    WHERE question_id = ?
    SQL
    results = QuestionsDatabase.instance.execute(query, question_id)
    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT questions.id, questions.title, questions.body, questions.user_id
    FROM question_followers
    JOIN questions
    ON (questions.id = question_followers.question_id)
    WHERE question_followers.user_id = ?
    SQL
    results = QuestionsDatabase.instance.execute(query, user_id)
    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    query = <<-SQL
    SELECT
      questions.id, questions.title, questions.body, questions.user_id
    FROM
      question_followers qf
    JOIN
      questions
    ON
    (questions.id = qf.question_id)
    GROUP BY
      qf.question_id
    ORDER BY
      COUNT(qf.question_id) DESC
      LIMIT ?
    SQL
    results = QuestionsDatabase.instance.execute(query, n)
    results.map { |result| Question.new(result) }
  end


end