FactoryBot.define do
  factory :recipe do
    transient do
      ingredient_descriptions { [] }
    end

    ingredients do
      ingredient_descriptions.map do |description|
        build(:ingredient, description: description)
      end
    end
  end
end
