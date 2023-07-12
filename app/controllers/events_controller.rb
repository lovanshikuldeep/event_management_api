class EventsController < ApplicationController
  before_action :find_event, only: [:show, :update, :destroy]

  def index
    @events = Event.all
    render json:@events
  end

  def show
    render json:@event
  end

  def create 
    @event = Event.new(event_params)
    if @event.save
      render json:@event
    else
      render error: {error:"unable to create event"} , status:400
    end
  end

  def update
    if @event
      @event.update(event_params)
      render json: {message: "event updated successfully"}, status: 200
    else
      render json: {message: "event not updated successfully"},status:400
    end
  end

  def destroy
    if @event
      @event.destroy
      render json: {message: "event deleted successfully"}, status:200
    else
      render json: {message: "event not deleted successfully"},status:400
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_time, :end_time,:user_id)
  end

  def find_event
    @event = Event.find(params[:id])
  end
end

