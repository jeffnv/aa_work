def factors number
  factors = 1.upto(number/2).to_a
  factors.select! do |factor_to_check|
    number % factor_to_check == 0
  end

  puts factors.join(', ')
end