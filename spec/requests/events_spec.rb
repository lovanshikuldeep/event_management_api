require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { FactoryBot.create :user}

  describe "GET /index" do
    it 'returns a success response with all events' do
      event1 = FactoryBot.create(:event)
      event2 = FactoryBot.create(:event)
      user1 = FactoryBot.create(:user)

      get :index

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(2)
    end
  end

  describe 'GET /show' do
    it 'assigns the requested event to @event' do
      event = FactoryBot.create(:event)

      get :show, params: { id: event.id }

      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #create' do
    before do
      payload = { user_id: user.id, exp: 7.days.from_now.to_i }
      token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
      request.headers['Authorization'] = "Bearer #{token}"
    end

    context 'with valid parameters' do
      let(:valid_params) do
        {
          event: {
            title: 'Birthdays',
            description: 'Birthday partys',
            location: 'indores',
            start_time: Time.now,
            end_time: Time.now + 2.hours,
            user_id: 1
          }
        }
      end

      it 'creates a new event' do
        expect {
          post :create, params: valid_params
        }.to change(Event, :count).by(1)
    
        expect(response).to have_http_status(:ok)

        event = Event.last
        expect(event.title).to eq('Birthdays')
        expect(event.description).to eq('Birthday partys')
        expect(event.location).to eq('indores')
        expect(event.start_time).to be_within(1.second).of(Time.now)
        expect(event.end_time).to be_within(1.second).of(Time.now + 2.hours)
        expect(event.user_id).to eq(user.id)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          event: {
            title: '', 
            description: '',
            location: 'indore',
            start_time: Time.now,
            end_time: Time.now + 2.hours,
            user_id: 1
          }
        }
      end

      it 'returns a bad request status' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:bad_request)

        expect(Event.count).to eq(0)
      end
    end
  end
end