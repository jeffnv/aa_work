class QuestionLike
  def self.likers_for_question_id(question_id)
    query = <<-SQL
    SELECT users.id, users.fname, users.lname
    FROM question_likes
    JOIN users
    ON (users.id = question_likes.user_id)
    WHERE question_id = ?
    SQL
    results = QuestionsDatabase.instance.execute(query, question_id)
    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
    SELECT COUNT(*) AS num
    FROM question_likes
    WHERE question_id = ?
    GROUP BY question_id
    SQL
    QuestionsDatabase.instance.execute(query, question_id).first['num']
  end

  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT questions.id, questions.title, questions.body, questions.user_id
    FROM question_likes
    JOIN questions
    ON (questions.id = question_likes.question_id)
    WHERE question_likes.user_id = ?
    SQL
    results = QuestionsDatabase.instance.execute(query, user_id)
    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    query = <<-SQL
    SELECT
     questions.id, questions.title, questions.body, questions.user_id
    FROM
      question_likes
    JOIN
      questions
    ON
      question_likes.question_id = questions.id
    GROUP BY
      question_likes.question_id
    ORDER BY
      COUNT(question_likes.question_id) DESC
      LIMIT ?
    SQL
    results = QuestionsDatabase.instance.execute(query, n)
    results.map { |result| Question.new(result) }
  end
end