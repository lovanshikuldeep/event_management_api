require 'rails_helper'

RSpec.describe User, type: :model do
  
  it 'you can run tests' do 
    user=FactoryBot.create(:user)
    expect(user).to be_valid
  end
  
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
