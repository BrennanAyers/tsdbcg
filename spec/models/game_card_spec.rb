require 'rails_helper'

RSpec.describe GameCard, type: :model do
  describe 'relationships' do
    it { should belong_to :game }
    it { should belong_to :card }
  end
end
