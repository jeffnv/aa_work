require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super("questions.db")

    self.results_as_hash = true

    self.type_translation = true
  end
end

class User
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

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def to_s
    "#{@fname} #{@lname}"
  end

end