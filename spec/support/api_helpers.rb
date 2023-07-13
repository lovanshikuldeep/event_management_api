module ApiHelpers
  def set_api_headers(user)
    request.headers['Authorization'] = "Bearer #{user.api_key}"
    request.headers['Content-Type'] = 'application/json'
  end
end
