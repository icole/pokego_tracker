# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'net/http'
require 'json'
require 'uri'

# URL of the API endpoint
url = 'https://pokemon-go-api.github.io/pokemon-go-api/api/pokedex.json'

uri = URI(url)

begin
  # Create the HTTP request
  response = Net::HTTP.get_response(uri)

  # Check if the request was successful
  if response.is_a?(Net::HTTPSuccess)
    # Parse the JSON response
    data = JSON.parse(response.body)

    # Assuming the response is an array of objects, loop through each
    if data.is_a?(Array)
      data.each_with_index do |item, index|
        Pokemon.create(
          name: item.dig('names', 'English'),
          image_url: item.dig('assets', 'image'),
          shiny_image_url: item.dig('assets', 'shinyName'),
          external_id: item['id']
        )
      end
    else
      puts "Expected an array but received a #{data.class}"
    end
  else
    puts "HTTP Request failed (status code: #{response.code})"
  end
rescue => e
  puts "An error occurred: #{e.message}"
end
