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

  # returns recipes ordered by percent of ingredients matching search_string
  # TODO: either use a search by ingredient id (if we find a way to parse them)
  # Or do a better search for full words (maybe use elasticsearch?)
  # TODO: add ingredients_count in recipes so we don't need to use subquery for total_count
  # TODO: list ingredients that everyone owns (salt, pepper...), ignore those in search
  def self.find_by_ingredients(search_string)
    return all unless search_string.present?

    # We remove any char not in French dictionary
    words_for_query = connection.quote(
      search_string.gsub(/[^a-zàâçéèêëîïôûùüÿñæœ ]/i, '').split(' ').join(' | ')
    )

    query = <<-SQL
      SELECT *,
             CASE
               WHEN total_count = 0 THEN 0
               ELSE round(100 * (1 - missing_count::decimal / total_count), 2)
             END AS percent_match
      FROM(
        SELECT *,
               (
                 SELECT COUNT(*)
                 FROM ingredients
                 WHERE ingredients.recipe_id = recipes.id
                   AND NOT to_tsvector(ingredients.description) @@ to_tsquery(#{words_for_query})
               ) AS missing_count,
               (
                 SELECT COUNT(*)
                 FROM ingredients
                 WHERE ingredients.recipe_id = recipes.id
               ) AS total_count
        FROM recipes
      ) sub
      ORDER BY percent_match DESC
    SQL

    select('*').from("(#{query}) AS recipes")
  end

  def as_json(*)
    super.slice('name', 'image', 'total_time').tap do |hash|
      hash['show_path'] = Rails.application.routes.url_helpers.recipe_path(self)

      # If the recipe was retrieved with find_by_ingredients, percent_match will be filled
      hash['percent_match'] = self.try(:percent_match)
    end
  end
end
