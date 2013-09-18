def fizzbuzz
  counter = 0
  while true
    if counter > 250 && ((counter % 7) == 0)
      puts "the number was #{counter}"
      return
    end
    counter += 1
  end
end