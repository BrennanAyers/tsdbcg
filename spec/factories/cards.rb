FactoryBot.define do
  factory :card do
  end

  factory :gold, parent: :card do
    name { "Gold" }
    category { "Money" }
    cost { 6 }
    victory_points { 0 }
    spending_power { 3 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./gold.jpg" }
    desc { "" }
    tags { "" }
  end

  factory :silver, parent: :card do
    name { "Silver" }
    category { "Money" }
    cost { 3 }
    victory_points { 0 }
    spending_power { 2 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./silver.jpg" }
    desc { "" }
    tags { "" }
  end

  factory :copper, parent: :card do
    name { "Copper" }
    category { "Money" }
    cost { 0 }
    victory_points { 0 }
    spending_power { 1 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./copper.jpg" }
    desc { "" }
    tags { "" }
  end

  factory :estate, parent: :card do
    name { "Estate" }
    category { "Victory" }
    cost { 2 }
    victory_points { 1 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./estate.jpg" }
    desc { "" }
    tags { "" }
  end

  factory :duchy, parent: :card do
    name { "Duchy" }
    category { "Victory" }
    cost { 5 }
    victory_points { 3 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./duchy.jpg" }
    desc { "" }
    tags { "" }
  end

  factory :province, parent: :card do
    name { "Province" }
    category { "Victory" }
    cost { 8 }
    victory_points { 6 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./province.jpg" }
    desc { "" }
    tags { "" }
  end

  factory :village, parent: :card do
    name { "Village" }
    category { "Action" }
    cost { 3 }
    victory_points { 0 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 2 }
    cards_to_draw { 1 }
    image { "./village.jpg" }
    desc { "" }
    tags { "+1 Card, +2 Actions" }
  end

  factory :militia, parent: :card do
    name { "Militia" }
    category { "Action, Attack" }
    cost { 4 }
    victory_points { 0 }
    spending_power { 2 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./militia.jpg" }
    desc { "Each other play discards down to 3 cards in their hand." }
    tags { "+2 Gold" }
  end

  factory :smithy, parent: :card do
    name { "Smithy" }
    category { "Action" }
    cost { 4 }
    victory_points { 0 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 3 }
    image { "./smithy.jpg" }
    desc { "" }
    tags { "+3 Cards" }
  end

  factory :market, parent: :card do
    name { "Market" }
    category { "Action" }
    cost { 5 }
    victory_points { 0 }
    spending_power { 1 }
    buying_power { 1 }
    actions_provided { 1 }
    cards_to_draw { 1 }
    image { "./market.jpg" }
    desc { "" }
    tags { "+1 Card, +1 Action, +1 Buy, +1 Gold" }
  end

  factory :mine, parent: :card do
    name { "Mine" }
    category { "Action" }
    cost { 5 }
    victory_points { 0 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./mine.jpg" }
    desc { "Trash a Treasure card from your hand. Gain a Treasure card costing up to 3 Treasure more; put it in your hand." }
    tags { "" }
  end

  factory :remodel, parent: :card do
    name { "Remodel" }
    category { "Victory" }
    cost { 4 }
    victory_points { 0 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./remodel.jpg" }
    desc { "Trash a card from your hand. Gain a card costing up to 2 treasure more than the trashed card." }
    tags { "" }
  end

  factory :cellar, parent: :card do
    name { "Cellar" }
    category { "Action" }
    cost { 2 }
    victory_points { 0 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 1 }
    cards_to_draw { 0 }
    image { "./cellar.jpg" }
    desc { "Discard any number of cards. +1 Card per card discarded." }
    tags { "+1 Action" }
  end

  factory :moat, parent: :card do
    name { "Moat" }
    category { "Action, Reaction" }
    cost { 2 }
    victory_points { 0 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 2 }
    image { "./moat.jpg" }
    desc { "When another player plays an Attack card, you maye reveal this from your hand. If you do, you are unaffected by that attack." }
    tags { "+2 Cards" }
  end

  factory :woodcutter, parent: :card do
    name { "Woodcutter" }
    category { "Action" }
    cost { 3 }
    victory_points { 0 }
    spending_power { 2 }
    buying_power { 1 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./woodcutter.jpg" }
    desc { "" }
    tags { "+1 Buy, +2 Gold" }
  end

  factory :workshop, parent: :card do
    name { "Workshop" }
    category { "Action" }
    cost { 3 }
    victory_points { 0 }
    spending_power { 0 }
    buying_power { 0 }
    actions_provided { 0 }
    cards_to_draw { 0 }
    image { "./workshop.jpg" }
    desc { "Gain a card costing up to 4 treasure." }
    tags { "" }
  end
end
