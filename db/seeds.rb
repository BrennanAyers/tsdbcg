# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  image_url = "localhost:3000/card_images"
elsif ENV[HEROKU_STAGING]
  image_url = "https://tsdbcg.herokuapp.com/card_images"
elsif Rails.env.production?
  image_url = "https://tsdbcg.herokuapp.com/card_images"
elsif Rails.env.test?
  image_url = "localhost:3000/card_images"
end

Card.create(name: "Copper", category: "Money", cost: 0, spending_power: 1, tags: "", desc: "", image: image_url + "Copper.jpg")
Card.create(name: "Silver", category: "Money", cost: 3, spending_power: 2, tags: "", desc: "", image: image_url + "Silver.jpg")
Card.create(name: "Gold", category: "Money", cost: 6, spending_power: 3, tags: "", desc: "", image: image_url + "Gold.jpg")
Card.create(name: "Estate", category: "Victory", cost: 2, victory_points: 1, tags: "", desc: "", image: image_url + "Estate.jpg")
Card.create(name: "Duchy", category: "Victory", cost: 5, victory_points: 3, tags: "", desc: "", image: image_url + "Duchy.jpg")
Card.create(name: "Province", category: "Victory", cost: 8, victory_points: 6, tags: "", desc: "", image: image_url + "Province.jpg")

Card.create(name: "Village", category: "Action", cost: 3, actions_provided: 2, cards_to_draw: 1, tags: "+1 Card,+2 Actions", desc: "", image: image_url + "Village.jpg")
Card.create(name: "Militia", category: "Action,Attack", cost: 4, spending_power: 2, tags: "+2 Gold", desc: "Each other play discards down to 3 cards in their hand.", image: image_url + "Militia.jpg")
Card.create(name: "Smithy", category: "Action", cost: 4, cards_to_draw: 3, tags: "+3 Cards", desc: "", image: image_url + "Smithy.jpg")
Card.create(name: "Market", category: "Action", cost: 5, actions_provided: 1, cards_to_draw: 1, spending_power: 1, buying_power: 1, tags: "+1 Card,+1 Action,+1 Buy,+1 Gold", desc: "", image: image_url + "Market.jpg")
Card.create(name: "Mine", category: "Action", cost: 5, tags: "", desc: "Trash a Treasure card from your hand. Gain a Treasure card costing up to 3 Treasure more; put it in your hand.", image: image_url + "Mine.jpg")
Card.create(name: "Remodel", category: "Action", cost: 4, tags: "", desc: "Trash a card from your hand. Gain a card costing up to 2 treasure more than the trashed card.", image: image_url + "Remodel.jpg")
Card.create(name: "Cellar", category: "Action", cost: 2, actions_provided: 1, tags: "+1 Action", desc: "Discard any number of cards. +1 Card per card discarded.", image: image_url + "Cellar.jpg")
Card.create(name: "Moat", category: "Action,Reaction", cost: 2, cards_to_draw: 2, tags: "+2 Cards", desc: "When another player plays an Attack card, you maye reveal this from your hand. If you do, you are unaffected by that attack.", image: image_url + "Moat.jpg")
Card.create(name: "Woodcutter", category: "Action", cost: 3, tags: "+1 Buy,+2 Gold", spending_power: 2, buying_power: 1, desc: "", image: image_url + "Woodcutter.jpg")
Card.create(name: "Workshop", category: "Action", cost: 3, tags: "", desc: "Gain a card costing up to 4 treasure.", image: image_url + "Workshop.jpg")
