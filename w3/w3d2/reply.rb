# CREATE TABLE replies (
#   id INTEGER PRIMARY KEY,
#
#   question_id INTEGER NOT NULL,
#   user_id INTEGER NOT NULL,
#   body VARCHAR(255) NOT NULL,
#
#   parent_reply_id INTEGER,
#   FOREIGN KEY (question_id) REFERENCES questions(id),
#   FOREIGN KEY (user_id) REFERENCES users(id)
#
# );



class Reply
  attr_accessor :fname, :lname
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM users")
    results.map { |result| User.new(result) }
  end

  def self.find_by_id(id)
    user_hash = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM
        users
      WHERE
        id=?;
    SQL

    if user_hash.empty?
      return nil
    else
      User.new(user_hash[0])
    end
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
    auth_q = []
    Question.all.each do |question|
      auth_q << question if question.user_id == @id
    end
    auth_q
  end

end