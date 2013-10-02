class Reply < SqlParent
  attr_accessor :question_id, :user_id, :body, :parent_reply_id
  attr_reader :id

  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    p results
    results.map { |result| Reply.new(result) }
  end

  def self.table_name
    "replies"
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE question_id = ?", question_id)
    results.map do |result|
      Reply.new(result)
    end
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE user_id = ?", user_id)
    results.map do |result|
      Reply.new(result)
    end
  end

  def initialize(options = {})
    @id = options["id"]
    @question_id = options["question_id"]
    @user_id = options["user_id"]
    @body = options["body"]
    @parent_reply_id = options["parent_reply_id"]
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE parent_reply_id = ?", @id)
    results.map do |result|
      Reply.new(result)
    end
  end

  def authored_questions
    auth_q = []
    Question.all.each do |question|
      auth_q << question if question.user_id == @id
    end
    auth_q
  end

  def save
    params = [self.question_id, self.user_id, self.body, self.parent_reply_id]
    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        INSERT INTO
          replies (question_id, user_id, body, parent_reply_id)
        VALUES
          (?, ?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        UPDATE replies
        SET question_id = ?, user_id = ?, body = ?, parent_reply_id = ?
        WHERE id = #{@id}
      SQL
    end
  end
end