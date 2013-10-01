class User < SqlParent
  attr_accessor :fname, :lname
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM users")
    results.map { |result| User.new(result) }
  end

  def self.table_name
    'users'
  end

  def self.find_by_name(fname, lname)
    user_hash = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM
        users
      WHERE
        fname=? AND lname = ?;
    SQL

    if user_hash.empty?
      return nil
    else
      User.new(user_hash[0])
    end
  end

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def to_s
    "#{@fname} #{@lname}"
  end

  def authored_questions
    # auth_q = []
    # Question.all.each do |question|
    #   auth_q << question if question.user_id == @id
    # end
    # auth_q
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT *
      FROM
        questions
      WHERE
        user_id=?
    SQL
    results.map { |result| Question.new(result) }
  end

  def authored_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT *
      FROM
        replies
      WHERE
        user_id=?
    SQL
    results.map { |result| Reply.new(result) }

  end

  def followed_questions
    QuestionFollowers.followed_questions_for_user_id(@id)
  end

end