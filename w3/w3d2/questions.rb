require 'singleton'
require 'sqlite3'
load 'sql_parent.rb'
load 'user.rb'
load 'question.rb'
load 'reply.rb'
load 'question_followers.rb'


class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super("questions.db")

    self.results_as_hash = true

    self.type_translation = true
  end
end

