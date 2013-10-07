require_relative './db_connection'

module Searchable
  def where(params)
    param_array = params.to_a.delete_if{|k,v| v.nil?}
    param_vals = param_array.map(&:last)
    where_str = param_array.map{|k,v|"#{k} = ?"}.join(' AND ')
    db_rows = DBConnection.execute(<<-SQL, param_vals)
    SELECT *
    FROM #{self.table_name}
    WHERE #{where_str}
    SQL
    db_rows.map{|params| self.new(params)}
  end
end