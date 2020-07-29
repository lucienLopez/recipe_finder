class RecipesController < ApplicationController
  before_action :set_recipe, only: :show

  def index; end

  def search
    render json: Recipe.find_by_ingredients(params[:search_text]).limit(30)
  end

  def show; end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
