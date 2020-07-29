require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '.find_by_ingredients' do
    context 'when passing multiple words' do
      let!(:expected_recipes) do
        [
          create(
            :recipe,
            ingredient_descriptions: [
            'Salt', '100g onion', 'one bowl rice', 'pork sausage'
            ]
          ),
          create(:recipe),
          create(
            :recipe,
            ingredient_descriptions: ['salt', '100g onion', 'one bowl rice']
          )
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
        expect(Recipe.find_by_ingredients('onion rice sausage salt')).to(
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

  describe '#as_json' do
    let(:recipe) do
      create(
        :recipe, name: 'test_name', image: 'https://example.com', total_time: '1h'
      )
    end

    it 'serializes correctly' do
      expect(recipe.as_json).to(
        eq(
          {
            'name' => 'test_name', 'image' => 'https://example.com',
            'total_time' => '1h', 'show_path' => "/recipes/#{recipe.id}"
          }
        )
      )
    end
  end
end
