class UsersController < ApplicationController
  #s before_action :authorize_request, except: [:index, :show]
  before_action :authenticate_request, only: [:create]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: {errors: @user.errots.full_messages}, status: :unprocessable_entity
    end  
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation)
  end
end
