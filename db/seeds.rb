# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
TIMES = 10
puts "clearing database"
Airplane.destroy_all
puts "database cleared"
puts "creating airplanes"
TIMES.times do 
  Airplane.enqueue(name: Faker::StarWars.vehicle, 
                  "size" => ["large","small"].sample,
                  "cargo_type" => ["passenger","cargo"].sample)
end
puts "airplanes created"