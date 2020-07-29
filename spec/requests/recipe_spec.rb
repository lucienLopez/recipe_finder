require 'rails_helper'


RSpec.describe 'recipe', type: :request do
  describe 'index' do
    it 'returns ok' do
      get '/recipes'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'show' do
    context 'when passing a valid id' do
      let(:recipe) { create(:recipe) }
      it 'returns ok' do
        get "/recipes/#{recipe.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when passing an invalid id' do
      it 'returns not_found' do
        get '/recipes/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'search' do
    context 'when searching with multiple words' do
      let!(:recipe) do
        create(
          :recipe, name: 'test_name', image: 'https://example.com', total_time: '1h',
          ingredient_descriptions: ['Salt', '100g onion']
        )
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

      it 'returns matching recipes' do
        get '/recipes/search', params: { format: :json, search_text: 'salt onion' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to(
          eq(
            [
              {
                'name' => 'test_name', 'image' => 'https://example.com',
                'total_time' => '1h', 'show_path' => "/recipes/#{recipe.id}"
              }
            ]
          )
        )
      end
    end
  end
end
