FactoryBot.define do
  factory :card do

  end

  factory :gold, parent: :card do
    name { "Gold" }
    type { "Money" }
    cost { 6 }
    victoryPoints { nil }
    spendingPower { 3 }
  end
  factory :silver, parent: :card do
    name { "Silver" }
    type { "Money" }
    cost { 3 }
    victoryPoints { nil }
    spendingPower { 2 }
  end
  factory :copper, parent: :card do
    name { "Copper" }
    type { "Money" }
    cost { 0 }
    victoryPoints { nil }
    spendingPower { 1 }
  end
  factory :estate, parent: :card do
    name { "Estate" }
    type { "Victory" }
    cost { 2 }
    victoryPoints { 1 }
    spendingPower { 0 }
  end
  factory :duchy, parent: :card do
    name { "Duchy" }
    type { "Victory" }
    cost { 5 }
    victoryPoints { 3 }
    spendingPower { 0 }
  end
  factory :province, parent: :card do
    name { "Province" }
    type { "Victory" }
    cost { 8 }
    victoryPoints { 6 }
    spendingPower { 0 }
  end
end
