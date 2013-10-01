class Question < SqlParent
  attr_accessor :title, :body, :user_id
  def self.table_name
    "questions"
  end
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    results.map { |result| Question.new(result) }
  end

  def self.find_by_author_id(id)
    obj_hash = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM
        questions
      WHERE
        user_id=?
    SQL

    if obj_hash.empty?
      return []
    else
      obj_hash.map { |result| Question.new(result) }
    end
  end

  def initialize(options = {})
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def to_s
    "#{@title} #{@body} by #{@user_id} - #{User.find_by_id(@user_id)}"
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollowers.followers_for_question_id(@id)
  end

end