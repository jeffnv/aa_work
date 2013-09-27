def stock_prices(calendar)
  max_diff = 0
  best_days = []
  calendar.each_index do |buy_index|
    (buy_index + 1...calendar.length).each do |sell_index|
      if calendar[sell_index] - calendar[buy_index] > max_diff
        max_diff = calendar[sell_index] - calendar[buy_index]
        best_days = [buy_index, sell_index]
      end
    end
  end
  best_days
end