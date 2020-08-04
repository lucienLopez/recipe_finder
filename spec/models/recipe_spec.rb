require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '.find_by_ingredients' do
    context 'when passing multiple words' do
      let!(:perfect_match) do
        create(
          :recipe,
          ingredient_descriptions: [
            'Salt', '100g onion', 'one bowl rice', 'pork sausage'
          ]
        )
      end

      let!(:no_match) do
        create :recipe, ingredient_descriptions: ['100g something', 'one bowl else']
      end

      let!(:bad_match) do
        create(
          :recipe,
          ingredient_descriptions: ['salt', '100g something', 'one bowl else']
        )
      end

      let!(:medium_match) do
        create(
          :recipe,
          ingredient_descriptions: ['salt', '100g onion', 'one bowl rice', 'milk']
        )
      end

      it 'orders recipes by matching ingredients percent' do
        expect(Recipe.find_by_ingredients('onion rice sausage salt').pluck(:id)).to(
          eq([perfect_match.id, medium_match.id, bad_match.id, no_match.id])
        )
      end
    end

    context 'when passing single word' do
      let!(:perfect_match) do
        create(
          :recipe,
          ingredient_descriptions: [
            '100g onion'
          ]
        )
      end

      let!(:no_match) do
        create :recipe, ingredient_descriptions: ['100g something', 'one bowl else']
      end

      let!(:bad_match) do
        create(
          :recipe,
          ingredient_descriptions: ['salt', '100g something', 'one small onion']
        )
      end

      let!(:medium_match) do
        create(
          :recipe,
          ingredient_descriptions: ['salt', 'Onion']
        )
      end

      it 'orders recipes by matching ingredients percent' do
        expect(Recipe.find_by_ingredients('onion').pluck(:id)).to(
          eq([perfect_match.id, medium_match.id, bad_match.id, no_match.id])
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
            'total_time' => '1h', 'show_path' => "/recipes/#{recipe.id}",
            'percent_match' => nil
          }
        )
      )
    end
  end
end
