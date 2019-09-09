FactoryBot.define do
  factory :card do
  end

  factory :gold, parent: :card do
    name { "Gold" }
    category { "Money" }
    cost { 6 }
    victory_points { nil }
    spending_power { 3 }
  end

  factory :silver, parent: :card do
    name { "Silver" }
    category { "Money" }
    cost { 3 }
    victory_points { nil }
    spending_power { 2 }
  end

  factory :copper, parent: :card do
    name { "Copper" }
    category { "Money" }
    cost { 0 }
    victory_points { nil }
    spending_power { 1 }
  end

  factory :estate, parent: :card do
    name { "Estate" }
    category { "Victory" }
    cost { 2 }
    victory_points { 1 }
    spending_power { nil }
  end

  factory :duchy, parent: :card do
    name { "Duchy" }
    category { "Victory" }
    cost { 5 }
    victory_points { 3 }
    spending_power { nil }
  end

  factory :province, parent: :card do
    name { "Province" }
    category { "Victory" }
    cost { 8 }
    victory_points { 6 }
    spending_power { nil }
  end
end
