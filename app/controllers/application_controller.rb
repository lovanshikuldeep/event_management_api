require 'jwt'
class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request
  
    header = request.headers['Authorization']
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_user = if decoded && decoded.key?(:user_id)
                        User.find(decoded[:user_id])
                        else
                        nil
                      end  
    
  end
end
