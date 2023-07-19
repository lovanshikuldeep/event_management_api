class PlacesController < ApplicationController

  def index
    url = "https://maps.googleapis.com/maps/api/place/textsearch/json?input=Resturant+in+indore&inputtype=textquery&2Cformatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=AIzaSyCqWHKkgLxJiSwS63bxfWpQ-XhSQs65H5c"
    response = RestClient.get(url)
    data = JSON.parse(response.body)

    results = data['results']
    places = []

    results.each do |result|
      place = {name:result['name'],id: result['place_id'],
      address: result['formatted_address'],
      favourites: @current_user.favourites.exists?(place_id:1)}
      places.append(place)
    end
    render json: places
  end

  def show
    @place = Place.find_by(id: params[:id])
    @name = @place.name
    @city = @place.city

    @url="https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{@name}+in+#{@city}&key=AIzaSyCqWHKkgLxJiSwS63bxfWpQ-XhSQs65H5c"

    response = RestClient.get(@url)
    finalresponse = JSON.parse(response.body)

    newoutput = finalresponse['results']
    restorents = []

    newoutput.each do |output|
      place = {name: output['name'],id: output['place_id'],address: output['formatted_address']}
      restorents.append(place)
    end
    render json: restorents
  end

  def create
    @place = Place.create(place_params)
    redirect_to places_path(@place)
  end

  def favourite 
    @favourite = @current_user.favourites
    @favourite.each do |name|
        name.place.name
      end
      
    render json:  @favourite.each do |name|
      name.place.name
    end
  end

  private
  
  def place_params
    params.permit(:name ,:city)
  end
end
