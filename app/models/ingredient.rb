# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  recipe_id   :bigint
#
# Indexes
#
#  index_ingredients_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
class Ingredient < ApplicationRecord
  belongs_to :recipe

  # TODO: find a way to parse description
  # to distinguish quantity and actual ingredient
end
