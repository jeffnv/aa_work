class RPNCalculator
  def value
    @stack[-1]
  end

  def initialize
    @stack = []
  end

  def push(value)
    @stack<< value
  end

  def math
    opp2 = @stack.pop
    opp1 = @stack.pop
    if(!opp2 || !opp1)
      raise "calculator is empty"
      @stack << opp1 if opp1
      @stack << opp2 if opp2
    else
      push(yield(opp1, opp2))
    end
  end

  def plus
    math{|x,y| x + y}
  end

  def minus
    math{|x,y| x - y}
  end

  def times
    math{|x,y| x * y}
  end

  def divide
    math{|x,y| x.to_f / y.to_f}
  end

  NUMS = ('1'..'9').to_a
  OPS = %w(+ - * /)
  def tokens(str)
    arr = []
    str.each_char do |item|
      if(NUMS.include?(item))
        arr << item.to_i
      elsif(OPS.include?(item))
        arr << item.to_sym
      end
    end
    arr
  end

  def get_user_input
    user_input = ""

    puts "Please enter number or operation."
    until user_input.include? "="
      user_input <<  gets.chomp
    end
    puts evaluate(user_input.chop)
  end

  def evaluate str
    arr = tokens(str)

    calc = RPNCalculator.new

    arr.each do |token|
      case token
      when 1..9
        calc.push token
      when :+
        calc.plus
      when :-
        calc.minus
      when :/
        calc.divide
      when :*
        calc.times
      else
        raise "unknown token encountered #{token}"
      end
    end
    calc.value
  end

end

if __FILE__ == $PROGRAM_NAME
  filename = ARGV[0]
  calc = RPNCalculator.new
  if filename.empty?
    calc.get_user_input
  else
    lines_to_evaluate = File.readlines(filename)
    output_file = File.open("#{filename}-results", 'w')
    lines_to_evaluate.each do |line|
      output_file << "#{calc.evaluate(line)}\n"
    end
    output_file.close
  end


end