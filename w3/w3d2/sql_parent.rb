class SqlParent

  def self.find_by_id(id)
    self.find_by_args({id: id})
  end

  def self.find_by_args(args)
    match_string = ""
    vals = []
    args.each do |key, val|
      match_string << "#{key} = ?\n"
      vals << val
    end
    match_string  = match_string.chomp + ';'
    query = <<-SQL
    SELECT *
    FROM
    #{self.table_name}
    WHERE
    #{match_string}
    SQL
    obj_id = QuestionsDatabase.instance.execute(query, *vals)
    if obj_id.empty?
      return nil
    else
      self.new(obj_id[0])
    end
  end
end