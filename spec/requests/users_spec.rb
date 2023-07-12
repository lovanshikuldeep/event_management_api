require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response with users' do
      user1 = FactoryBot.create(:user, name: 'User 1')
      user2 = FactoryBot.create(:user, name: 'User 2')

      get :index

      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(2)
      expect(parsed_response[0]['name']).to eq(user1.name)
      expect(parsed_response[1]['name']).to eq(user2.name)
    end
  end

  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns a success response with the user' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(user.id)
      expect(parsed_response['name']).to eq(user.name)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { name: 'John', email: 'john@example.com', password: 'password',user_name: 'jhon23' }
        }.to change(User, :count).by(1)
      end

      it 'returns a JSON response with the new user' do
        post :create, params: { name: 'John', email: 'john@example.com', password: 'password', user_name: 'jhon23'}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to eq(User.last.to_json)
      end
    end
  end 
end


