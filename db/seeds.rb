recipes = JSON.parse(File.read("#{Rails.root}/db/seeds/recipes.json"))
recipes.each do |recipe_hash|
  tags = recipe_hash['tags'].map { |tag| Tag.find_or_create_by(name: tag) }
  ingredients = recipe_hash['ingredients'].map do |ingredient|
    Ingredient.new(description: ingredient)
  end
  recipe_hash['tags'] = tags
  recipe_hash['ingredients'] = ingredients
  Recipe.create(recipe_hash.except('nb_comments'))
end
