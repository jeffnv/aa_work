def super_print(input_string, options = {})
  defaults = {
    upcase: false,
    times: 1,
    reverse: false,
  }

  options = defaults.merge(options)

  input_string.upcase! if options[:upcase]
  input_string.reverse! if options[:reverse]
  puts input_string*options[:times]

end