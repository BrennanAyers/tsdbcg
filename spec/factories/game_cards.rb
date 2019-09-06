FactoryBot.define do
  factory :game_card do
    game_id { nil }
    card_id { nil }
    trashed { false }
    discarded { false }
  end
end
