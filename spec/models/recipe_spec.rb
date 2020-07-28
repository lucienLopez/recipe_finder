require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:expected_recipes) do
    [
      create(
        :recipe, ingredient_descriptions: ['100g onion', 'one bowl rice', 'pork sausage']
      ),
      create(:recipe),
      create(:recipe, ingredient_descriptions: ['100g onion', 'one bowl rice'])
    ]
  end

  let!(:other_recipes) do
    create :recipe, ingredient_descriptions: ['100g something', 'one bowl else']
    create(
      :recipe, ingredient_descriptions: [
        '100g onion', 'one bowl rice', 'pork sausage', 'French fries'
      ]
    )
  end

  describe '.find_by_ingredients' do
    it 'filters correctly' do
      expect(Recipe.find_by_ingredients('onion rice sausage')).to(
        contain_exactly(*expected_recipes)
      )
    end
  end
end
