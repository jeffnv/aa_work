require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require_relative './db_connection.rb'

class AssocParams
  def other_class
    params[:class_name].constantize
  end

  def other_table
    other_class.table_name
  end
end

class BelongsToAssocParams < AssocParams
  attr_reader :name, :params
  def initialize(name, params = {})
    @name = name.to_s
    params[:class_name] ||= @name.camelcase
    params[:foreign_key] ||= @name + '_id'
    params[:primary_key] ||= "id"
    @params = params
  end

  def type
    :belongs_to
  end
end

class HasManyAssocParams < AssocParams
  attr_reader :params
  def initialize(name, params, self_class)
    @name = name.to_s.singularize
    params[:class_name] ||= @name.camelcase
    params[:foreign_key] ||= @name + '_id'
    params[:primary_key] ||= "id"
    @params = params   
  end

  def type
    :has_many
  end
end

module Associatable
  def assoc_params
    
  end

  def belongs_to(name, params = {})
    btp = BelongsToAssocParams.new(name, params)
    define_method(name.to_sym) do 
      sql = <<-SQL
      SELECT other.*
      FROM #{btp.other_table} other
      JOIN #{self.class.table_name} this 
      ON 
      other.#{btp.params[:primary_key]} = this.#{btp.params[:foreign_key]}
      WHERE this.id = #{self.id}
      SQL
      puts sql
      owners = DBConnection.execute(sql)
      btp.other_class.parse_all(owners)[0]
    end
  end

  def has_many(name, params = {})
    hsp = HasManyAssocParams.new(name, params, self.class)
    #want an array of all the cat's that have self.id in their foreign key
    define_method(name.to_sym) do 
      sql = <<-SQL
      SELECT other.*
      FROM #{hsp.other_table} other
      JOIN #{self.class.table_name} this 
      ON 
      other.#{hsp.params[:foreign_key]} = this.#{hsp.params[:primary_key]}
      WHERE this.id = #{self.id}
      SQL
      puts sql
      many = DBConnection.execute(sql)
      p many
      hsp.other_class.parse_all(many)
    end
  end

  def has_one_through(name, assoc1, assoc2)
  end
end
