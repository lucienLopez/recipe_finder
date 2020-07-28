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
end
