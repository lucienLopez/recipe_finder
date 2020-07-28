# == Schema Information
#
# Table name: recipes
#
#  id              :bigint           not null, primary key
#  author          :string
#  author_tip      :string
#  budget          :string
#  cook_time       :string
#  difficulty      :string
#  image           :string
#  name            :string
#  people_quantity :string
#  prep_time       :string
#  rate            :string
#  total_time      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Recipe < ApplicationRecord
  has_and_belongs_to_many :tags
  has_many :ingredients

  # look for recipes where all ingredients match at least one searched word
  def self.find_by_ingredients(search_string)
    return all unless search_string.present?

    words_for_like = search_string.split(' ').map { |word| connection.quote("%#{word}%") }

    where.not(
      Ingredient.where('ingredients.recipe_id = recipes.id')
        .where(
          <<-SQL
            ingredients.description NOT LIKE
            #{words_for_like.join(' AND ingredients.description NOT LIKE ')}
          SQL
        ).select(1).arel.exists
    )
  end
end
