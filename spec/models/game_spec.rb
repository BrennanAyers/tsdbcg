require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'relationships' do
    it { should have_many :cards }
    it { should have_many :players }
  end
end
