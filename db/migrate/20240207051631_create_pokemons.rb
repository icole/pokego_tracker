class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :image_url
      t.string :shiny_image_url
      t.string :external_id

      t.timestamps
    end
  end
end
