json.extract! pokemon, :id, :name, :image_url, :shiny_image_url, :external_idg, :created_at, :updated_at
json.url pokemon_url(pokemon, format: :json)
