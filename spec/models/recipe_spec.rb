require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '.find_by_ingredients' do
    context 'when passing multiple words' do
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
          :recipe,
          ingredient_descriptions: [
            '100g onion', 'one bowl rice', 'pork sausage', 'French fries'
          ]
        )
      end

      it 'filters correctly' do
        expect(Recipe.find_by_ingredients('onion rice sausage')).to(
          contain_exactly(*expected_recipes)
        )
      end
    end

    context 'when passing single word' do
      let!(:expected_recipes) do
        [
          create(
            :recipe, ingredient_descriptions: ['100g onion']
          ),
          create(:recipe),
        ]
      end

      let!(:other_recipes) do
        create :recipe, ingredient_descriptions: ['100g something', 'one bowl else']
        create(
          :recipe,
          ingredient_descriptions: [
            '100g onion', 'one bowl rice', 'pork sausage', 'French fries'
          ]
        )
      end

      it 'filters correctly' do
        expect(Recipe.find_by_ingredients('onion')).to(
          contain_exactly(*expected_recipes)
        )
      end
    end

    context 'when passing empty string' do
      let!(:recipe_no_ingredient) { create(:recipe) }
      let!(:recipe_multiple_ingredient) do
        create(:recipe, ingredient_descriptions: ['100g onion', 'one bowl rice'])
      end

      it 'returns all' do
        expect(Recipe.find_by_ingredients('').count).to eq(2)
      end
    end
  end
end
