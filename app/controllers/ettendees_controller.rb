class EttendeesController < ApplicationController
before_action :find_ettendee, only: [:show, :update, :destroy]

  def index
    @ettendees = Attendee.all
    render json:@ettendees
  end

  def show
    render json:@ettendee
  end

  def create 
    @ettendee = Attendee.create(ettendee_params)
    if @ettendee.save
      render json:@ettendee
    else
      render error: {error:"unable to create attendee"} , status:400
    end
  end

  def update
    if @ettendee
      @ettendee.update(ettendee_params)
      render json: {message: "attendee updated successfully"}, status: 200
    else
      render json: {message: "attendee not updated successfully"},status:400
    end
  end

  def destroy
    if @ettendee
      @ettendee.destroy
      render json: {message: "attendee deleted successfully"}, status:200
    else
      render json: {message: "attendee not deleted successfully"},status:400
    end
  end

  private

  def ettendee_params
    params.require(:attendee).permit(:name, :phone_number, :event_id)
  end

  def find_ettendee
    @ettendee = Attendee.find(params[:id])
  end
end
