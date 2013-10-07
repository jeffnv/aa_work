class Object
  def self.new_attr_accessor(*args)
    
    args.each do |sym|
      
      define_method(sym.to_s << '=') do |val|
        instance_variable_set('@' << sym.to_s, val)
      end
      
      define_method(sym){instance_variable_get('@' << sym.to_s)}
    end
  end
  
end



class Dog
  new_attr_accessor :noise, :color
  def initialize
    @noise = 'bark'
    @color = 'brown'
  end
end

a = Dog.new
puts a.noise
puts a.color

a.color = 'black'
a.noise = 'woof'
puts a.color
puts a.noise