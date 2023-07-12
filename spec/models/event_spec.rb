require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it 'you can create event' do 
      event=FactoryBot.create(:event)
      expect(event).to be_valid
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:location) }
  end
end
