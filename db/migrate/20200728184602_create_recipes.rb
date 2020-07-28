class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :recipes do |t|
      t.string :rate
      t.string :author_tip
      t.string :budget
      t.string :prep_time
      t.string :name
      t.string :author
      t.string :difficulty
      t.string :people_quantity
      t.string :cook_time
      t.string :total_time
      t.string :image

      t.timestamps
    end

    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true, index: true
      t.string :description

      t.timestamps
    end

    create_join_table :recipes, :tags
  end
end
