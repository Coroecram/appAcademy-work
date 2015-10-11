def stockpicker(day_prices)
  return [] if day_prices.length <= 1
  result = []
  max_profit = 0

  (0...day_prices.length).each do |start_indx|
    (start_indx...day_prices.length).each do |end_indx|
      curr_profit = day_prices[end_indx] - day_prices[start_indx]

      if curr_profit > max_profit
        max_profit = curr_profit
        result = [start_indx, end_indx]
      end

    end
  end

  result

end
