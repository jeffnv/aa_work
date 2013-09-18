def remix(ingredients)

  alcohols = []
  mixers = []

  ingredients.each do |ingredient_pair|
    alcohols << ingredient_pair[0]
    mixers << ingredient_pair[1]
  end

  alcohols.shuffle.zip(mixers.shuffle)

end