require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET /index" do
    it 'returns a success response with all events' do
      event1 = FactoryBot.create(:event)
      event2 = FactoryBot.create(:event)

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
    context 'with valid parameters' do
      let(:event) { create(:event) }

      it 'creates a new event' do
          post :create, params: {event: {title: 'pool',description: "a pool party",location:'indore',start_time:"2014-01-01",end_time:'2014-02-02'}}
          expect(assigns(:event)).to be_a(Event)
          expect(assigns(:event)).to be_persisted
      end
    end
  end
end
