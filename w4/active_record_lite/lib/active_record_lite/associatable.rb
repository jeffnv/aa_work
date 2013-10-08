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
    @assoc_params ||= {}
  end

  def belongs_to(name, params = {})
    btp = BelongsToAssocParams.new(name, params)
    assoc_params[name] = btp
    define_method(name.to_sym) do 
      sql = <<-SQL
      SELECT *
      FROM #{btp.other_table} other
      WHERE other.#{btp.params[:primary_key]} = ?
      SQL
      owners = DBConnection.execute(sql, self.send(btp.params[:foreign_key]))
      btp.other_class.parse_all(owners)[0]
    end
  end

  def has_many(name, params = {})
    hsp = HasManyAssocParams.new(name, params, self.class)
    assoc_params[name] = hsp
    define_method(name.to_sym) do 
      sql = <<-SQL
      SELECT *
      FROM #{hsp.other_table} other
      WHERE other.#{hsp.params[:foreign_key]}  = ?
      SQL
      many = DBConnection.execute(sql, self.id)
      hsp.other_class.parse_all(many)
    end
  end

  def has_one_through(name, assoc1, assoc2)
    define_method(name.to_sym) do
      as1_prms = self.class.assoc_params[assoc1]
      as2_prms = as1_prms.other_class.assoc_params[assoc2]
      
      if as1_prms.type == :belongs_to
        where_str = "t1.#{as1_prms.params[:primary_key]} = ?"
        where_var = self.send(as1_prms.params[:foreign_key])
      else
        where_str = "t1.#{as1_prms.params[:foreign_key]} = ?"
        where_var = self.id
      end
      
      if as2_prms.type == :belongs_to
        on_str = "t1.#{as2_prms.params[:foreign_key]} = 
        t2.#{as2_prms.params[:primary_key]}"
      else
        on_str = "t1.#{as2_prms.params[:primary_key]} = 
        t2.#{as2_prms.params[:foreign_key]}"
      end
      
      sql = <<-SQL
      SELECT t2.*
      FROM #{as1_prms.other_table} t1
      JOIN #{as2_prms.other_table} t2
      ON #{on_str}
      WHERE #{where_str}
      LIMIT 1
      SQL
      
      results = DBConnection.execute(sql, where_var)
      as2_prms.other_class.parse_all(results)[0]
    end
    
  end
end
