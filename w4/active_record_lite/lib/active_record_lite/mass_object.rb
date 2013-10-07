class MassObject
  def self.my_attr_accessible(*attributes)
    @attributes =  attributes
    attributes.each do |sym|
      attr_accessor sym
    end
  end

  def self.attributes
    @attributes
  end

  def self.parse_all(results)
    results.map{|params|self.new(params)}
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      if(self.class.attributes.include?(attr_name.to_sym))
        instance_variable_set('@' << attr_name.to_s, val)
      else
        raise "mass assignment to unregistered attribute #{attr_name}"
      end
    end
  end
end