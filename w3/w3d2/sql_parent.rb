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

  # def self.save_obj(params)
  #   raise "already saved!" if params['id']
  #
  #   #params is a hash like {'id' => 1, 'fname' => 'david', 'lname' => 'board'}
  #   keys = []
  #   vals = []
  #
  #   params.each do |k, v|
  #     keys << k
  #     vals << v
  #   end
  #
  #   QuestionsDatabase.instance.execute(<<-SQL, *vals)
  #   INSERT INTO
  #   #{self.table_name} #{keys.join(', ')}
  #   VALUES
  #   (#{vals.map{'?'}.join(', ')})
  #   SQL
  #
  #   @id = QuestionsDatabase.instance.last_insert_row_id
  # end
end