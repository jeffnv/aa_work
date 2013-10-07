require_relative './associatable'
require_relative './db_connection'
require_relative './mass_object'
require_relative './searchable'
require 'active_support/inflector' #we need to 'ClassName'.underscore.pluralize

class SQLObject < MassObject
  def self.set_table_name(table_name = self.class.to_s.underscore.pluralize)
    @table_name = table_name
  end

  def self.table_name
    @table_name
  end

  def self.all
    attr_rows = DBConnection.execute(<<-SQL)
    SELECT *
    FROM #{@table_name}
    SQL
    attr_rows.map do |attrs|
      puts attrs
      self.new(attrs)
    end
  end


  def self.find(id)
    attr_rows = DBConnection.execute(<<-SQL, id)
    SELECT *
    FROM #{@table_name}
    WHERE id = ?
    SQL
    unless(attr_rows.empty?)
      self.new(attr_rows[0])
    else
      nil
    end
  end

  def create
    attrs = self.class.attributes.zip(attribute_values)
    attrs.delete_if{|key, val|val.nil?}
    attr_names = attrs.map(&:first).join(', ')
    attr_vals = attrs.map(&:last)
    questions = (['?'] * attr_vals.count).join(', ')
    query = <<-SQL
    INSERT INTO #{self.class.table_name} 
  (#{attr_names})
    VALUES
  (#{questions})
    SQL
    
    puts "********running the following:\n#{query}\n\nwith#{attr_vals.inspect}"
    DBConnection.execute(query, attr_vals)
    @id = DBConnection.last_insert_row_id
  end

  def update
    attr_str = self.class.attributes.map{|name|name.to_s << ' = ?'}.join(', ')
    DBConnection.execute(<<-SQL, attribute_values, @id)
    UPDATE #{self.class.table_name}
    SET #{attr_str}
    WHERE id = ?
    SQL
     
  end
  
  def save
    if(@id.nil?)
      create
    else
      update
    end
  end

  def attribute_values
    attr_vals = self.class.attributes.map do |attr_name| 
      instance_variable_get('@' << attr_name.to_s)
    end
    "attr_vals: #{attr_vals}"
    attr_vals
  end
end
