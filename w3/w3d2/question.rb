class Question
  attr_accessor :title, :body, :user_id
  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    results.map { |result| Question.new(result) }
  end

  def self.find_by_id(id)
    obj_id = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM
        questions
      WHERE
        id=?;
    SQL

    if obj_id.empty?
      return nil
    else
      Question.new(obj_id[0])
    end
  end

  # def self.find_by_name(title, body, user_id)
  #   user_hash = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
  #     SELECT *
  #     FROM
  #       users
  #     WHERE
  #       fname=? AND lname = ?;
  #   SQL
  #
  #   if user_hash.empty?
  #     return nil
  #   else
  #     User.new(user_hash[0])
  #   end
  # end

  def initialize(options = {})
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def to_s
    "#{@title} #{@body} by #{@user_id} - #{User.find_by_id(@user_id)}"
  end

end